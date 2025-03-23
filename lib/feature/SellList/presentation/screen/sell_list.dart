import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/feature/SellList/presentation/screen/sell_details_screen.dart';

class SellListScreen extends StatefulWidget {
  const SellListScreen({super.key, required this.salesList});

  final List<Map<String, dynamic>> salesList;
  static const String name = "sell_list";

  @override
  State<SellListScreen> createState() => _SellListScreenState();
}

class _SellListScreenState extends State<SellListScreen> {
  late List<Map<String, dynamic>> localSalesList;
  String searchQuery = "";
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    localSalesList = List.from(widget.salesList);
  }

  // Search function for filtering the list
  void searchSalesList(String query) async {
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

    // Query Firestore to find matches based on customer name
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('NewSell')
        .where('customerName', isGreaterThanOrEqualTo: query)
        .where('customerName', isLessThanOrEqualTo: query + '\uf8ff')
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
      appBar: AppBar(title: const Text("Sell List")),
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
              onChanged: searchSalesList,
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? _buildSalesList(searchResults)
                : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('NewSell')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No sales found!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return _buildSalesList(snapshot.data!.docs);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build the list of sales, either filtered or all
  Widget _buildSalesList(List<QueryDocumentSnapshot> salesList) {
    return ListView.builder(
      itemCount: salesList.length,
      itemBuilder: (context, index) {
        var sale = salesList[index];
        var saleData = sale.data() as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellDetailsScreen(
                    shopName: saleData['shopName'],
                    customerName: saleData['customerName'],
                    address: saleData['address'],
                    phoneNumber: saleData['phoneNumber'],
                    date: saleData['date'],
                    products: (saleData['products'] as List<dynamic>)
                        .map((item) => Map<String, String>.from(item))
                        .toList(),
                    totalPrice: (saleData['totalPrice'] as num).toDouble(),
                    mujuri: (saleData['mujuri'] as num).toDouble(),
                    discount: (saleData['discount'] as num).toDouble(),
                    pay: (saleData['pay'] as num).toDouble(),
                    finalPrice: (saleData['finalPrice'] as num).toDouble(),
                  ),
                ),
              );
            },
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
                  Text("${index + 1}.", style: const TextStyle(fontSize: 15)),
                  Text("Name: ${saleData['customerName']}", style: const TextStyle(fontSize: 15)),
                  Text("Money: ${saleData['pay']}", style: const TextStyle(fontSize: 15)),
                  GestureDetector(
                    onTap: () => _deleteSale(sale.id, context),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 🔥 Firestore Delete Function
  void _deleteSale(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('NewSell').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sale deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting sale: $e")),
      );
    }
  }
}
