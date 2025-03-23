import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class SellDetailsScreen extends StatelessWidget {
  final String shopName;
  final String customerName;
  final String address;
  final String phoneNumber;
  final String date;
  final List<Map<String, String>> products;
  final double totalPrice;
  final double mujuri;
  final double discount;
  final double pay;
  final double finalPrice;

  const SellDetailsScreen({
    super.key,
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

  Future<void> generateAndOpenPDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Invoice", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text("Shop Name: $shopName", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Customer Name: $customerName", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Address: $address", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Phone Number: $phoneNumber", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Date: $date", style: pw.TextStyle(fontSize: 18)),
                pw.Divider(),
                pw.Text("Product List:", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(

                  headers: ["Product Name", "Carret", "Vori", "Ana", "Rothi", "Point"],
                  data: products.map((prod) => [
                    prod["Product Name"] ?? "",
                    prod["Carret"] ?? "",
                    prod["Vori"] ?? "",
                    prod["Ana"] ?? "",
                    prod["Rothi"] ?? "",
                    prod["Point"] ?? "",
                  ]).toList(),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.orange),
                  headerStyle: pw.TextStyle(color: PdfColors.white,fontWeight: pw.FontWeight.bold)
                ),

                pw.Text("Total Price: $totalPrice", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text("Mujuri: $mujuri", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Discount: $discount", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Paid: $pay", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Remaining: $finalPrice", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.red)),

                pw.SizedBox(height: 20), // Some spacing before the logo

                // Logo positioned at the bottom right
                // pw.Row(
                //   mainAxisAlignment: pw.MainAxisAlignment.end,
                //   children: [
                //     pw.Container(
                //       height: 50, // Set logo height
                //       width: 50, // Set logo width
                //       child: pw.Image(
                //         pw.MemoryImage("logoBytes"), // Use your image bytes here
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
      ),
    );

    // Get the directory to store the file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/sell_details.pdf";

    // Save the file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell Details")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Shop Name: $shopName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Customer Name: $customerName", style: const TextStyle(fontSize: 16)),
              Text("Address: $address", style: const TextStyle(fontSize: 16)),
              Text("Phone Number: $phoneNumber", style: const TextStyle(fontSize: 16)),

              Text("Date: $date", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              const Text("Product List:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(products[index]["Product Name"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(products[index]["Carret"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      subtitle: Text(
                        "Vori: ${products[index]["Vori"]} | Ana: ${products[index]["Ana"]} | Rothi: ${products[index]["Rothi"]} | Point: ${products[index]["Point"]}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Text("Total Price: $totalPrice", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Mujuri: $mujuri", style: const TextStyle(fontSize: 16)),
              Text("Discount: $discount", style: const TextStyle(fontSize: 16)),
              Text("Paid: $pay", style: const TextStyle(fontSize: 16)),
              Text("Remaining: $finalPrice", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  onPressed: () => generateAndOpenPDF(context),
                  child: const Text("Print", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
