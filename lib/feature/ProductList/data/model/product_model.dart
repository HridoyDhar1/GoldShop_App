class ProductModel {
  final List<Map<String, String>> products;

  final double pay;

  ProductModel({required this.products, required this.pay});

  // Convert to JSON for saving
  Map<String, dynamic> toMap() {
    return {"products": products, "money": pay};
  }

  // // Create an instance from JSON
  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(
  //     products: List<Map<String, String>>.from(json["products"]),
  //
  //     pay: json["pay"],
  //   );
  // }
}
