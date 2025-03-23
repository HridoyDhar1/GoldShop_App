import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtherCostListScreen extends StatefulWidget {
  const OtherCostListScreen({super.key, required this.costList});

  final List<Map<String, dynamic>> costList;
  static const String name = "other_cost_list";

  @override
  State<OtherCostListScreen> createState() => _OtherCostListScreenState();
}

class _OtherCostListScreenState extends State<OtherCostListScreen> {
  // Create a local copy of the list
  late List<Map<String, dynamic>> localCostList;

  String searchQuery = "";
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;

  void searchCostList(String query) async {
    setState(() {
      searchQuery = query.toLowerCase();
      isSearching = true;
    });

    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('OtherCost')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      searchResults = snapshot.docs;
      isSearching = false;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Other Cost List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by  Name",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: searchCostList,
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? _buildOtherCostList(searchResults)
                : StreamBuilder(
              stream: FirebaseFirestore.instance.collection("OtherCost").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No worker found!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return _buildOtherCostList(snapshot.data!.docs);
              },
            ),
          ),
        ],
      ),
    );
  }
Widget _buildOtherCostList(List<QueryDocumentSnapshot> costList) {
    return ListView.builder(
            itemCount: costList.length,
            itemBuilder: (context, index) {
              var cost = costList[index];
              var costData = cost.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffF7FAFF),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("${index + 1}", style: const TextStyle(fontSize: 15)),
                      Text("Name: ${costData['name']}", style: const TextStyle(fontSize: 15)),
                      Text("Money: ${costData['money']}", style: const TextStyle(fontSize: 15)),
                      GestureDetector(
                        onTap: () => _deleteCost(cost.id, context),
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
  void _deleteCost(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('OtherCost')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting pay: $e")),
      );
    }
  }
}
