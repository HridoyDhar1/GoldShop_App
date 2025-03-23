import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/feature/BuyList/presentaion/screen/buy_list_details.dart';
import 'package:goldshop/feature/ProductList/presentation/screen/product_details.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.productList});

  final List<Map<String, dynamic>> productList;
  static const String name = "product_list";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Create a local copy of the list
  late List<Map<String, dynamic>> localProductList;

  @override
  void initState() {
    super.initState();
    localProductList = List.from(widget.productList); // Copy the passed list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Product List")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("AddProduct").snapshots(),
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
          var productList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var product = productList[index];
              var productData = product.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProductDetailsScreen(
                              products:
                                  (productData['products'] as List<dynamic>)
                                      .map(
                                        (item) =>
                                            Map<String, String>.from(item),
                                      )
                                      .toList(),
                              pay: double.tryParse(productData['money'].toString()) ?? 0.0,
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
                        // Text(
                        //   "Name: ${buyData['sellerName']}",
                        //   style: const TextStyle(fontSize: 15),
                        // ),
                        Text(
                          "Money: ${productData['money']}",
                          style: const TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () => _deleteProduct(product.id, context),
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // 🔥 Firestore Delete Function
  void _deleteProduct(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('AddProduct').doc(docId).delete();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Deleted successfully")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error deleting mortgage: $e")));
    }
  }
}
