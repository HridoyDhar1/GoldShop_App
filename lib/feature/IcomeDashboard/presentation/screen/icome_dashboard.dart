import 'package:flutter/material.dart';

class IncomeDashboardScreen extends StatefulWidget {
  final double addMoney;
  final double totalSell;
  final double totalMortgage; // Value from Mortgage Page
  final double otherCost;
  final double totalBuy;
  final double sendMoney;
  final double mortgagePay;
  final double money;

  const IncomeDashboardScreen({
    super.key,
    required this.addMoney,
    required this.totalSell,
    required this.totalMortgage, // Now received from Mortgage Page
    required this.otherCost,
    required this.totalBuy,
    required this.sendMoney,
    required this.mortgagePay, required this.money,
  });

  static const String name = "/income_dashboard";

  @override
  State<IncomeDashboardScreen> createState() => _IncomeDashboardScreenState();
}

class _IncomeDashboardScreenState extends State<IncomeDashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Income Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  Color(0xff1B353C),
              ),
              child:  Center(
                child: Text(
                  "${widget.money}",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                summaryRow('Add Money', '৳ ${widget.addMoney.toStringAsFixed(2)}'),
                summaryRow('Sell', '৳ ${widget.totalSell.toStringAsFixed(2)}'),
                summaryRow('Mortgage', '৳ ${widget.totalMortgage.toStringAsFixed(2)}'), // Updated
                summaryRow('Other Cost', '৳ ${widget.otherCost.toStringAsFixed(2)}'),
                summaryRow('Buy', '৳ ${widget.totalBuy.toStringAsFixed(2)}'),
                summaryRow('Pay', '৳ ${widget.sendMoney.toStringAsFixed(2)}'),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(
            amount,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
