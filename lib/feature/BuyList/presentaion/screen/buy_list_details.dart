import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class BuyDetailsScreen extends StatelessWidget {
  final String sellerName;

  final String address;
  final String phoneNumber;
  final String date;
  final List<Map<String, String>> products;

  final double pay;

  const BuyDetailsScreen({
    super.key,
    required this.sellerName,

    required this.address,
    required this.phoneNumber,
    required this.date,
    required this.products,

    required this.pay,

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
                pw.Text("Information", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text("Worker Name: $sellerName", style: pw.TextStyle(fontSize: 18)),

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


                pw.Text("Money: $pay", style: pw.TextStyle(fontSize: 18)),


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
    final filePath = "${directory.path}/buy_details.pdf";

    // Save the file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buy Details")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: $sellerName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

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

              Text("Money: $pay", style: const TextStyle(fontSize: 16)),

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
