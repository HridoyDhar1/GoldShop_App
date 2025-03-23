import 'package:flutter/material.dart';

class MortgagePayModel {

  final String customerName;

  final String date;

  final double money;

  MortgagePayModel({

    required this.customerName,

    required this.date,

    required this.money,
  });

  // ✅ Convert to JSON for Firestore
  Map<String, dynamic> toMap() {
    return {

      "customerName": customerName,
      "date":date,


      "pay": money, // ✅ Corrected key (was "Money")
    };
  }
//
// // ✅ Factory constructor to create an object from Firestore
// factory MortgageModel.fromJson(Map<String, dynamic> json) {
//   return MortgageModel(
//     shopName: json['shopName'] ?? '',
//     customerName: json['customerName'] ?? '',
//     address: json['address'] ?? '',
//     phoneNumber: json['phoneNumber'] ?? '',
//     date: json['date'] ?? '',
//     products: (json['products'] as List<dynamic>)
//         .map((item) => Map<String, String>.from(item))
//         .toList(),
//     percentage: json['percentage'] ?? '',
//     money: (json['money'] as num).toDouble(),
//   );
// }
}
