import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/core/widgets/custom_datapicker.dart';
import 'package:goldshop/core/widgets/custom_floatingaction_button.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/MortgageList/data/model/mortgage_model.dart';
import 'package:goldshop/feature/MortgageList/presentation/screen/mortgage_list.dart';
import 'package:goldshop/feature/MortgageList/presentation/screen/mortgage_list_details.dart';
import 'package:goldshop/feature/NewSell/presentation/widget/product_text_field.dart';

class NewMortgageScreen extends StatefulWidget {
  const NewMortgageScreen({super.key});

  static const String name = "new_mortgage";

  @override
  State<NewMortgageScreen> createState() => _NewMortgageScreenState();
}

class _NewMortgageScreenState extends State<NewMortgageScreen> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  final _dateController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _mortgagePercentController = TextEditingController();

  List<TextEditingController> nameControllers = [];
  List<TextEditingController> carretControllers = [];
  List<TextEditingController> voriControllers = [];
  List<TextEditingController> anaControllers = [];
  List<TextEditingController> rothiControllers = [];
  List<TextEditingController> pointControllers = [];

  List<TextEditingController> payMoneyController = [];

  List<Widget> payiFields = [];
  List<Map<String, dynamic>> mortgageList = [];

  double pay = 0.0;
  int textFieldCount = 1;
  List<Map<String, String>> totalProducts =
  []; // List to store entered products
  int totalVori = 0,
      totalAna = 0,
      totalRothi = 0,
      totalPoint = 0; // Total variables

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < textFieldCount; i++) {
      nameControllers.add(TextEditingController());
      carretControllers.add(TextEditingController());
      voriControllers.add(TextEditingController());
      anaControllers.add(TextEditingController());
      rothiControllers.add(TextEditingController());
      pointControllers.add(TextEditingController());
    }
  }

  // Save Data

  void _saveAndShowDetails() async {
    print("Button clicked");
    _addProductToList();
    MortgageModel mortgageModel = MortgageModel(
      percentage: _mortgagePercentController.text,
      shopName: _shopNameController.text,
      customerName: _customerNameController.text,
      address: _addressController.text,
      phoneNumber: _phoneNumberController.text,
      date: _dateController.text,
      products: totalProducts,
      money: pay,
    );

    // Save data
    try {
      // Save data to Firestore
      await FirebaseFirestore.instance.collection('NewMortgage').add(
         mortgageModel.toMap());
      print("Data Saved Successfully!");

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Saved Successfully!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MortgageListScreen(mortgageList: mortgageList),
        ),
      );
      // show details
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                MortgageDetailsScreen(
                  shopName: _shopNameController.text,
                  customerName: _customerNameController.text,
                  address: _addressController.text,
                  phoneNumber: _phoneNumberController.text,
                  date: _dateController.text,
                  products: totalProducts,
                  pay: pay,
                  percentage: _mortgagePercentController.text,
                ),
          ),
        );
      });
    }catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving data!")),
      );
    }


  }

  // Calculate total product
  void _addProductToList() {
    totalVori = 0;
    totalAna = 0;
    totalRothi = 0;
    totalPoint = 0;
    totalProducts.clear(); // Clear previous data

    for (int i = 0; i < textFieldCount; i++) {
      setState(() {
        var vori = int.tryParse(voriControllers[i].text) ?? 0;
        var ana = int.tryParse(anaControllers[i].text) ?? 0;
        var rothi = int.tryParse(rothiControllers[i].text) ?? 0;
        var point = int.tryParse(pointControllers[i].text) ?? 0;

        totalProducts.add({
          "Product Name": nameControllers[i].text,
          "Carret": carretControllers[i].text,
          "Vori": vori.toString(),
          "Ana": ana.toString(),
          "Rothi": rothi.toString(),
          "Point": point.toString(),
        });

        // Accumulate totals
        totalVori += vori;
        totalAna += ana;
        totalRothi += rothi;
        totalPoint += point;
      });
    }

    // Conversion Logic: Loop until no more conversions are needed
    bool conversionOccurred;
    do {
      conversionOccurred = false;

      // Convert 16 Ana into 1 Vori
      if (totalAna >= 16) {
        totalVori += totalAna ~/ 16; // Add extra Vori
        totalAna = totalAna % 16; // Remaining Ana after conversion
        conversionOccurred = true;
      }

      // Convert 10 Rothi into 1 Ana
      if (totalRothi >= 10) {
        totalAna += totalRothi ~/ 10; // Add extra Ana
        totalRothi = totalRothi % 10; // Remaining Rothi after conversion
        conversionOccurred = true;
      }

      // Convert 10 Point into 1 Rothi
      if (totalPoint >= 10) {
        totalRothi += totalPoint ~/ 10; // Add extra Rothi
        totalPoint = totalPoint % 10; // Remaining Points after conversion
        conversionOccurred = true;
      }

      // Repeat the loop if any conversion occurred
    } while (conversionOccurred);
  }

  // Pay Field
  void addPayField() {
    setState(() {
      TextEditingController newController = TextEditingController();
      payMoneyController.add(newController);

      payiFields.add(
        CustomTextField(
          text: "Money",
          valid: "Enter money",
          labelText: "Money",
          controller: newController,
          icons: Icons.money,
          keyboard: TextInputType.number,
          onChanged: (value) {
            setState(() {
              pay = double.tryParse(value) ?? 0.0;
            }); // ✅ Ensure UI updates when text changes
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: Text("New Mortgage", style: TextStyle(fontSize: 20)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 200,
                    child: DatePickerTextField(controller: _dateController),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: "Shop Name",
                  text: "",
                  valid: "Enter Shop Name",
                  controller: _shopNameController,
                  icons: Icons.store,
                  keyboard: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: "Customer Name",
                  text: "",
                  valid: "Enter customer Name",
                  controller: _customerNameController,
                  icons: Icons.person,
                  keyboard: TextInputType.text,
                ),
                CustomTextField(
                  labelText: "Address",
                  text: "",
                  valid: "Enter address Name",
                  controller: _addressController,
                  icons: Icons.home,
                  keyboard: TextInputType.text,
                ),
                CustomTextField(
                  labelText: "Phone Number",
                  text: "",
                  valid: "Enter phone Name",
                  controller: _phoneNumberController,
                  icons: Icons.phone,
                  keyboard: TextInputType.text,
                ),
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: CustomTextField(
                      labelText: "100-5%",
                      text: "",
                      valid: "Enter mortgage ",
                      controller: _mortgagePercentController,
                      icons: Icons.percent,
                      keyboard: TextInputType.text,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Product Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: textFieldCount,
                  itemBuilder: (context, index) {
                    return ProductTextField(
                      textFieldCount: 1,
                      nameControllers: [nameControllers[index]],
                      carretControllers: [carretControllers[index]],
                      voriControllers: [voriControllers[index]],
                      anaControllers: [anaControllers[index]],
                      rothiControllers: [rothiControllers[index]],
                      pointControllers: [pointControllers[index]],
                    );
                  },
                ),
                if (payMoneyController.isNotEmpty) ...payiFields,

                const SizedBox(height: 20),

                Divider(),
                const SizedBox(height: 10),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _addProductToList();
                          });

                          // Show dialog with total product details
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Total Product Details"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Total Vori: $totalVori",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Total Ana: $totalAna",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Total Rothi: $totalRothi",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Total Point: $totalPoint",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Interest: ${_mortgagePercentController
                                          .text}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "Money: $pay",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Close"),
                                  ),
                                ],
                              );
                            },
                          );
                        },

                        child: Text(
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _saveAndShowDetails();
                            print("object");
                          });
                        },

                        child: Text(
                          "Save",
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
      ),
      floatingActionButton: CustomFloatingActionButton(
        isExpanded: isExpanded,
        onToggle: toggleExpansion,
        labels: ['Product', 'Pay'],
        onPressed: (label) {
          setState(() {
            if (label == 'Product') {
              // Add product-related text fields
              textFieldCount++;
              nameControllers.add(TextEditingController());
              carretControllers.add(TextEditingController());
              voriControllers.add(TextEditingController());
              anaControllers.add(TextEditingController());
              rothiControllers.add(TextEditingController());
              pointControllers.add(TextEditingController());
            } else if (label == 'Pay') {
              // Handle Money button functionality (Add relevant fields here)
              addPayField();
            }
          });
        },
      ),
    );
  }
}
