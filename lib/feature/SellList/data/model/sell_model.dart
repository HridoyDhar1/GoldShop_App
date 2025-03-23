//
//
// class SellModel {
//   final String shopName;
//   final String customerName;
//   final String address;
//   final String phoneNumber;
//   final String date;
//   final List<Map<String, String>> products;
//   final double totalPrice;
//   final double mujuri;
//   final double discount;
//   final double pay;
//   final double finalPrice;
//
//   SellModel({
//     required this.shopName,
//     required this.customerName,
//     required this.address,
//     required this.phoneNumber,
//     required this.date,
//     required this.products,
//     required this.totalPrice,
//     required this.mujuri,
//     required this.discount,
//     required this.pay,
//     required this.finalPrice,
//   });
//
//   // Convert to JSON for saving
//   Map<String, dynamic> toJson() {
//     return {
//       "shopName": shopName,
//       "customerName": customerName,
//       "address": address,
//       "phoneNumber": phoneNumber,
//       "date": date,
//       "products": products,
//       "totalPrice": totalPrice,
//       "mujuri": mujuri,
//       "discount": discount,
//       "pay": pay,
//       "finalPrice": finalPrice,
//     };
//   }
//
//   // Create an instance from JSON
//   factory SellModel.fromJson(Map<String, dynamic> json) {
//     return SellModel(
//       shopName: json["shopName"],
//       customerName: json["customerName"],
//       address: json["address"],
//       phoneNumber: json["phoneNumber"],
//       date: json["date"],
//       products: List<Map<String, String>>.from(json["products"]),
//       totalPrice: json["totalPrice"],
//       mujuri: json["mujuri"],
//       discount: json["discount"],
//       pay: json["pay"],
//       finalPrice: json["finalPrice"],
//     );
//   }
// }
class SellModel {
  String shopName;
  String customerName;
  String address;
  String phoneNumber;
  String date;
  List<Map<String, String>> products;
  double totalPrice;
  double mujuri;
  double discount;
  double pay;
  double finalPrice;

  SellModel({
    required this.shopName,
    required this.customerName,
    required this.address,
    required this.phoneNumber,
    required this.date,
    required this.products,
    required this.totalPrice,
    required this.mujuri,
    required this.discount,
    required this.pay,
    required this.finalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'customerName': customerName,
      'address': address,
      'phoneNumber': phoneNumber,
      'date': date,
      'products': products,
      'totalPrice': totalPrice,
      'mujuri': mujuri,
      'discount': discount,
      'pay': pay,
      'finalPrice': finalPrice,
    };
  }
}
