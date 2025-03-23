import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final String nameController;
  final String addressController;
  final String birthdayController;
  final String phoneController;

  final String emailController;

  final String phoneNumberController;

  final String nidController;

  final String fatherNameController;

  final String motherNameController;

  final String fatherPhoneNumberController;

  final String motherPhoneNumberController;

  final String imageController;
  final String monthlyController;

  const EmployeeDetailsScreen({
    super.key,
    required this.nameController,
    required this.monthlyController,
    required this.birthdayController,
    required this.phoneController,
    required this.emailController,
    required this.phoneNumberController,
    required this.nidController,
    required this.fatherNameController,
    required this.motherNameController,
    required this.fatherPhoneNumberController,
    required this.motherPhoneNumberController,
    required this.addressController,
    required this.imageController,
  });

  Future<void> generateAndOpenPDF(BuildContext context) async {
    final pdf = pw.Document();
    final imageFile = File(imageController);
    pw.Widget profileImageWidget = pw.Container();
    if (imageFile.existsSync()) {
      final imageBytes = await imageFile.readAsBytes();
      final profileImage = pw.MemoryImage(imageBytes);
      profileImageWidget = pw.Center(
        child: pw.Image(profileImage, width: 100, height: 100),
      );
    }

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
                  "Employee Information",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Employee Name: $nameController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),

                pw.Text(
                  "Address: $addressController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Phone Number: $phoneController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Date: $birthdayController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Father Name: $fatherNameController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Mother Name: $motherNameController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Mother Phone Number: $motherPhoneNumberController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Father Phone Number: $fatherPhoneNumberController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Nid : $nidController",
                  style: pw.TextStyle(fontSize: 18),
                ),pw.SizedBox(height: 10),
                pw.Text(
                  "Monthly: $monthlyController",
                  style: pw.TextStyle(fontSize: 18),
                ),

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
    final filePath = "${directory.path}/Employee Information.pdf";

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
      appBar: AppBar(title: const Text("Employee Information")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 200,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: Colors.grey,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //
              //       imageController.isNotEmpty
              //           ? Image.file(File(imageController), fit: BoxFit.cover)
              //           : Icon(Icons.image, size: 50, color: Colors.white),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 20),
              Text(
                "Employee Name: $nameController",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
const SizedBox(height: 10),
              Text(
                "Address: $addressController",
                style: TextStyle(fontSize: 18),
              ),const SizedBox(height: 10),
              Text(
                "Phone Number: $phoneController",
                style: TextStyle(fontSize: 18),
              ),const SizedBox(height: 10),
              Text("Date: $birthdayController", style: TextStyle(fontSize: 18)),const SizedBox(height: 10),
              Text(
                "Father Name: $fatherNameController",
                style: TextStyle(fontSize: 18),
              ),const SizedBox(height: 10),
              Text(
                "Mother Name: $motherNameController",
                style: TextStyle(fontSize: 18),
              ),const SizedBox(height: 10),
              Text(
                "Mother Phone Number: $motherPhoneNumberController",
                style: TextStyle(fontSize: 18),
              ),const SizedBox(height: 10),
              Text(
                "Father Phone Number: $fatherPhoneNumberController",
                style: TextStyle(fontSize: 18),
              ),const SizedBox(height: 10),
              Text("Nid : $nidController", style: TextStyle(fontSize: 18)),const SizedBox(height: 10),
              Text(
                "Monthly: $monthlyController",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 50),

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
