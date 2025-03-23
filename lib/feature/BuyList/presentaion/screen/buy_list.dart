import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/feature/BuyList/presentaion/screen/buy_list_details.dart';

class BuyListScreen extends StatefulWidget {
  const BuyListScreen({super.key, required this.buyList});

  final List<Map<String, dynamic>> buyList;
  static const String name = "buy_list";

  @override
  State<BuyListScreen> createState() => _BuyListScreenState();
}

class _BuyListScreenState extends State<BuyListScreen> {
  late List<Map<String, dynamic>> localBuyList;
  String searchQuery = "";
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    localBuyList = List.from(widget.buyList);
  }

  // Search function for filtering the list
  void searchBuyList(String query) async {
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

    // Query Firestore to find matches based on seller name or other attributes
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('NewBuy')
        .where('sellerName', isGreaterThanOrEqualTo: query)
        .where('sellerName', isLessThanOrEqualTo: query + '\uf8ff')
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
      appBar: AppBar(title: const Text("Buy List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by  Name",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: searchBuyList,
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? _buildBuyList(searchResults)
                : StreamBuilder(
              stream: FirebaseFirestore.instance.collection("NewBuy").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nothing found!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return _buildBuyList(snapshot.data!.docs);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build the list of buy items, either filtered or all
  Widget _buildBuyList(List<QueryDocumentSnapshot> buyList) {
    return ListView.builder(
      itemCount: buyList.length,
      itemBuilder: (context, index) {
        var buy = buyList[index];
        var buyData = buy.data() as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyDetailsScreen(
                    sellerName: buyData["sellerName"],
                    address: buyData["address"],
                    phoneNumber: buyData["phoneNumber"],
                    date: buyData["date"],
                    products: (buyData['products'] as List<dynamic>)
                        .map((item) => Map<String, String>.from(item))
                        .toList(),
                    pay: buyData['pay'],
                  ),
                ),
              );
            },
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
                  Text(
                    "${index + 1}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "Name: ${buyData['sellerName']}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "Money: ${buyData['pay']}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () => _deleteBuy(buy.id, context),
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
  void _deleteBuy(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('NewBuy').doc(docId).delete();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Deleted successfully")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error deleting buy: $e")));
    }
  }
}
