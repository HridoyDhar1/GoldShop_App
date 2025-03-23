import 'package:flutter/material.dart';

class MortgageModel {
  final String shopName;
  final String customerName;
  final String address;
  final String phoneNumber;
  final String date;
  final List<Map<String, String>> products;
  final String percentage;
  final double money;

  MortgageModel({
    required this.percentage,
    required this.shopName,
    required this.customerName,
    required this.address,
    required this.phoneNumber,
    required this.date,
    required this.products,
    required this.money,
  });

  // ✅ Convert to JSON for Firestore
  Map<String, dynamic> toMap() {
    return {
      "shopName": shopName,
      "customerName": customerName,
      "address": address,
      "phoneNumber": phoneNumber,
      "date": date,
      "products": products.map((product) => Map<String, dynamic>.from(product)).toList(), // ✅ Convert list properly
      "percentage": percentage,
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
