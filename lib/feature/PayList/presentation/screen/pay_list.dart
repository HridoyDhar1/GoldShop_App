import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PayListScreen extends StatefulWidget {
  const PayListScreen({super.key, required this.payList});

  final List<Map<String, dynamic>> payList;
  static const String name = "pay_list";

  @override
  State<PayListScreen> createState() => _PayListScreenState();
}

class _PayListScreenState extends State<PayListScreen> {
  late List<Map<String, dynamic>> localPayList;

  String searchQuery = "";
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    localPayList = List.from(widget.payList);
  }

  // Improved search function
  void searchPayList(String query) async {
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

    // Use case-insensitive query search
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("NewPay")
        .where("name", isGreaterThanOrEqualTo: query)
        .where("name", isLessThanOrEqualTo: query + '\uf8ff')
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
      appBar: AppBar(title: const Text("Pay List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Name",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: searchPayList,
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? _buildMortgageList(searchResults)
                : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("NewPay")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No pay list found!",
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

  Widget _buildMortgageList(List<QueryDocumentSnapshot<Object?>> payList) {
    return payList.isEmpty
        ? const Center(child: Text("No pay list found"))
        : ListView.builder(
      itemCount: payList.length,
      itemBuilder: (context, index) {
        var pay = payList[index];
        var payData = pay.data() as Map<String, dynamic>;

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
                Text(
                  "${index + 1}.",
                  style: const TextStyle(fontSize: 15),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name: ${payData['name']}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Date: ${payData['date']}",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Text(
                  "Money: ${payData['money']}",
                  style: const TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () => _deletePay(pay.id, context),
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deletePay(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('NewPay')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pay deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting pay: $e")),
      );
    }
  }
}
