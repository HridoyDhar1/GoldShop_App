import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PayDetailsScreen extends StatelessWidget {
  final String name;

  final String phoneNumber;
  final String date;
  final List<Map<String, String>> payingList;

  final double money;

  const PayDetailsScreen({
    super.key,

    required this.phoneNumber,
    required this.date,
    required this.name,
    required this.payingList,
    required this.money,
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
                pw.Text(
                  "Paying Information",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text("Name: $name", style: pw.TextStyle(fontSize: 18)),

                pw.Text(
                  "Phone Number: $phoneNumber",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text("Date: $date", style: pw.TextStyle(fontSize: 18)),
                pw.Text("Money: $money", style: pw.TextStyle(fontSize: 18)),

                pw.SizedBox(height: 20),
                // Some spacing before the logo

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
    final filePath = "${directory.path}/paying_information.pdf";

    // Save the file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
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
              Text(
                "Name: $name",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Phone Number: $phoneNumber",
                style: const TextStyle(fontSize: 16),
              ),

              Text("Date: $date", style: const TextStyle(fontSize: 16)),
              Text("Money: $money", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                  ),
                  onPressed: () => generateAndOpenPDF(context),
                  child: const Text(
                    "Print",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
