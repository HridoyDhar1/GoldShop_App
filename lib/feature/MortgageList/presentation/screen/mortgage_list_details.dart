import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/core/widgets/custom_datapicker.dart';
import 'package:goldshop/core/widgets/custom_floatingaction_button.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/MortgageList/data/model/mortgage_pay_model.dart';
import 'package:goldshop/feature/MortgageList/presentation/screen/mortgage_pay_list.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class MortgageDetailsScreen extends StatefulWidget {
  final String shopName;
  final String customerName;
  final String address;
  final String phoneNumber;
  final String date;
  final List<Map<String, String>> products;
  final String percentage;
  final double pay;

  const MortgageDetailsScreen({
    super.key,
    required this.percentage,
    required this.shopName,
    required this.customerName,
    required this.address,
    required this.phoneNumber,
    required this.date,
    required this.products,

    required this.pay,
  });

  @override
  State<MortgageDetailsScreen> createState() => _MortgageDetailsScreenState();
}

class _MortgageDetailsScreenState extends State<MortgageDetailsScreen> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

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
                  "Invoice",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Shop Name: ${widget.shopName}",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  "Customer Name: ${widget.customerName}",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  "Address: ${widget.address}",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  "Phone Number: ${widget.phoneNumber}",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  "Date: ${widget.date}",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  "Interest: ${widget.percentage}",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  "Product List:",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Table.fromTextArray(
                  headers: [
                    "Product Name",
                    "Carret",
                    "Vori",
                    "Ana",
                    "Rothi",
                    "Point",
                  ],
                  data:
                      widget.products
                          .map(
                            (prod) => [
                              prod["Product Name"] ?? "",
                              prod["Carret"] ?? "",
                              prod["Vori"] ?? "",
                              prod["Ana"] ?? "",
                              prod["Rothi"] ?? "",
                              prod["Point"] ?? "",
                            ],
                          )
                          .toList(),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.orange),
                  headerStyle: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 20),
                pw.Text(
                  "Paid: ${widget.pay}",
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.Text("Total Amount to Pay: ${totalPaid.toStringAsFixed(2)}"),
                pw.Text("Remaining Amount: ${remainingAmount.toStringAsFixed(2)}",style: pw.TextStyle(color:PdfColors.red,fontWeight: pw.FontWeight.bold)), //


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
    final filePath = "${directory.path}/mortgage_details.pdf";

    // Save the file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  List<Widget> interestFields = [];
  List<Widget> dateFields = [];
  List<Widget> payFields = [];
  List<TextEditingController> interestController = [];
  List<TextEditingController> dateController = [];
  List<TextEditingController> payMoneyController = [];
  List<Map<String, dynamic>> mortgagePayList = [];

  double pay = 0.0;
  double interest = 0.0;
  double remainingAmount = 0.0;
  double totalPaid=0.0;

  /// add pay field
  void addPayField() {
    setState(() {
      TextEditingController newController = TextEditingController();
      payMoneyController.add(newController);
      payFields.add(
        CustomTextField(
          text: "Pay",
          valid: "Enter bill",
          controller: newController,
          icons: Icons.money,
          keyboard: TextInputType.text,
        ),
      );
    });
  }



  // add add field
  void addDateField() {

    setState(() {

      TextEditingController dateselectController = TextEditingController();
      dateController.add(dateselectController);

      dateFields.add(
       DatePickerTextField(controller: dateselectController)
      );
    });
  }



  double totalAmountToPay = 0.0; // Store the total amount including interest

  void calculateDateRange(String selectedDate) {
    try {
      DateTime initialDate = DateFormat("dd-MM-yyyy").parse(widget.date);
      DateTime enteredDate = DateFormat("dd-MM-yyyy").parse(selectedDate);
      int differenceInDays = enteredDate.difference(initialDate).inDays;

      if (differenceInDays < 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Invalid Date Selection"),
              content: const Text("Selected date should be after the initial date."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }

      double timeInMonths = differenceInDays / 30; // Convert days to months
      double principal = widget.pay;
      double rate = double.tryParse(widget.percentage) ?? 0.0;

      // Correct calculation of interest and total payable amount
      double interest = (principal * rate * timeInMonths) / 100;
      totalAmountToPay = principal + interest;

      // Calculate total paid from user inputs
      totalPaid = 0.0;
      for (var controller in payMoneyController) {
        totalPaid += double.tryParse(controller.text) ?? 0.0;
      }

      // Calculate remaining balance
      remainingAmount = totalAmountToPay - totalPaid;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Payment Details"),
            content: Text(
              "Duration: $differenceInDays days (~${timeInMonths.toStringAsFixed(2)} months)\n"
                  "Principal: $principal\n"
                  "Interest: ${interest.toStringAsFixed(2)}\n"
                  "Total Payable: ${totalAmountToPay.toStringAsFixed(2)}\n"
                  "Total Paid: ${totalPaid.toStringAsFixed(2)}\n"
                  "Remaining Amount: ${remainingAmount.toStringAsFixed(2)}",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint("Error: Invalid date format - $selectedDate");
    }
  }

  void _saveAndShowDetails() async {
    print("Button clicked");

    // Get the latest values from the payMoneyController and dateController
    String selectedDate = dateController.isNotEmpty ? dateController.last.text : '';
    double payAmount = 0.0;

    // Calculate total pay from user inputs
    for (var controller in payMoneyController) {
      payAmount += double.tryParse(controller.text) ?? 0.0;
    }

    // Check if the payAmount is valid (greater than 0)
    if (payAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid payment amount")),
      );
      return; // Don't proceed to next page
    }

    // Ensure the model uses the correct data (payAmount and selectedDate)
    MortgagePayModel mortgagePayModel = MortgagePayModel(
      customerName: widget.customerName, // Customer name from widget
      date: selectedDate, // Get the selected date from dateController
      money: payAmount, // Calculate total paid using payMoneyController
    );

    try {
      // Save data to Firestore
      await FirebaseFirestore.instance.collection('MortgagePay').add(
          mortgagePayModel.toMap());
      print("Data Saved Successfully!");

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Saved Successfully!")),
      );

      // Proceed to the next page only if data is valid
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MortgagePayListScreen(mortgageList: mortgagePayList),
        ),
      );
    } catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving data!")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mortgage Details")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shop Name: ${widget.shopName}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Customer Name: ${widget.customerName}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Address: ${widget.address}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Phone Number: ${widget.phoneNumber}",
                style: const TextStyle(fontSize: 16),
              ),

              Text(
                "Date: ${widget.date}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Interest: ${widget.percentage}",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                "Product List:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.products[index]["Product Name"] ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            widget.products[index]["Carret"] ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "Vori: ${widget.products[index]["Vori"]} | Ana: ${widget.products[index]["Ana"]} | Rothi: ${widget.products[index]["Rothi"]} | Point: ${widget.products[index]["Point"]}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),

              Text("Paid: ${widget.pay}", style: const TextStyle(fontSize: 16)),
             Text("Total Amount to Pay: ${totalPaid.toStringAsFixed(2)}"),
        Text("Remaining Amount: ${remainingAmount.toStringAsFixed(2)}"), //
              if(dateController.isNotEmpty)...dateFields,
              if(interestController.isNotEmpty)...interestFields,
              if(payMoneyController.isNotEmpty)...payFields,

              const SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
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
                      onPressed: () {
                        _saveAndShowDetails();
                        // Get the selected date from the DatePickerTextField controller
                        String selectedDate = dateController.isNotEmpty ? dateController.last.text : '';

                        // Call the calculateDateRange function with the selected date
                        calculateDateRange(selectedDate);
                      },
                      child: const Text(
                        "Calculate",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    ElevatedButton(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        isExpanded: isExpanded,
        onToggle: toggleExpansion,
        labels: ['Date', 'Pay'],
        onPressed: (label) {


          setState(() {

            if(label=="Date"){

       addDateField();

            }else if(label =="Pay"){
              addPayField();
            }
          });
        },
      ),
    );
  }
}
