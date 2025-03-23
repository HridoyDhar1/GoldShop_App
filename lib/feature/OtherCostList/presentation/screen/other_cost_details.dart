import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class OtherCostDetailsScreen extends StatelessWidget {
  final String name;
  final List<Map<String, dynamic>> costs;
  final double totalPrice;

  const OtherCostDetailsScreen({
    super.key,
    required this.name,
    required this.costs,
    required this.totalPrice,
  });

  /// Function to generate and open PDF
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
                pw.Text(
                  "Other Cost Details",
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),

                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(
                  headers: ["Name"],
                  data: costs.map((item) => [item["name"] ?? "", "${item["money"] ?? 0.0}"]).toList(),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.orange),
                  headerStyle: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold),
                ),
              pw. SizedBox(height: 20),
                pw.Text(
                  "Total Price: ${totalPrice.toStringAsFixed(2)}",
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold,color: PdfColors.red),
                ),
              ],
            ),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/cost_details.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Other Cost Details")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: costs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        costs[index]["name"] ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        "${costs[index]["money"]?.toStringAsFixed(2) ?? "0.00"}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Total Price: ${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
              ),
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
