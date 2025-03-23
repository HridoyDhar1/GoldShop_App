import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MortgagePayListScreen extends StatefulWidget {
  const MortgagePayListScreen({super.key, required this.mortgageList});
  final List<Map<String, dynamic>> mortgageList;
  static const String name = "mortgage_list";

  @override
  State<MortgagePayListScreen> createState() => _MortgagePayListScreenState();
}

class _MortgagePayListScreenState extends State<MortgagePayListScreen> {
  String searchQuery = "";
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;

  void searchMortgages(String query) async {
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
        .collection("MortgagePay")
        .where("customerName", isGreaterThanOrEqualTo: query)
        .where("customerName", isLessThanOrEqualTo: query + '\uf8ff')
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
      appBar: AppBar(title: const Text("Mortgage List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Name",
                suffixIcon:  Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: searchMortgages,
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? _buildMortgageList(searchResults)
                : StreamBuilder(
              stream: FirebaseFirestore.instance.collection("MortgagePay").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No mortgage found!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return _buildMortgageList(snapshot.data!.docs);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMortgageList(List<QueryDocumentSnapshot> mortgageList) {
    return mortgageList.isEmpty
        ? const Center(
      child: Text(
        "No mortgage found!",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    )
        : ListView.builder(
      itemCount: mortgageList.length,
      itemBuilder: (context, index) {
        var mortgage = mortgageList[index];
        var mortgageData = mortgage.data() as Map<String, dynamic>;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 70,
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
                Text("Name: ${mortgageData['customerName']}", style: const TextStyle(fontSize: 15)),
                Text("Date: ${mortgageData['date']}", style: const TextStyle(fontSize: 15)),
                Text("Pay: ${mortgageData['pay']}", style: const TextStyle(fontSize: 15)),
                GestureDetector(
                  onTap: () => _deleteMortgage(mortgage.id, context),
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔥 Firestore Delete Function
  void _deleteMortgage(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('MortgagePay').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mortgage deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting mortgage: $e")),
      );
    }
  }
}
