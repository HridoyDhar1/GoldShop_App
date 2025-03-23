import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/core/widgets/custom_datapicker.dart';
import 'package:goldshop/core/widgets/custom_floatingaction_button.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/BuyList/data/model/buy_model.dart';
import 'package:goldshop/feature/BuyList/presentaion/screen/buy_list_details.dart';
import 'package:goldshop/feature/NewSell/presentation/widget/product_text_field.dart';

class NewBuyScreen extends StatefulWidget {
  const NewBuyScreen({super.key});

  static const String name = "new_buy";

  @override
  State<NewBuyScreen> createState() => _NewBuyScreenState();
}

class _NewBuyScreenState extends State<NewBuyScreen> {
  List<Widget> buyFields = [];
  List<Map<String, dynamic>> buyingList = [];

  double pay = 0.0;
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  // Save Details
  void _saveAndShowDetails() async {
    print("Button Clicked");
    _addProductToList(); // Ensure product list is updated before navigation
    double totalPay = 0.0;
    for (var controller in payMoneyController) {
      totalPay += double.tryParse(controller.text) ?? 0.0;
    }

    // Create BuyModel instance
    BuyModel buyModel = BuyModel(
      sellerName: _sellerNameController.text,
      address: _addressController.text,
      phoneNumber: _phoneNumberController.text,
      date: _dateController.text,
      products: totalProducts,
      pay: totalPay,
    );

    try {
      // Save data to Firestore
      await FirebaseFirestore.instance
          .collection('NewBuy')
          .add(buyModel.toMap());

      print("Data Saved Successfully!");

      // Show confirmation message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data Saved Successfully!")));

      // Delay before navigating to BuyDetailsScreen
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => BuyDetailsScreen(
                  sellerName: _sellerNameController.text,
                  address: _addressController.text,
                  phoneNumber: _phoneNumberController.text,
                  date: _dateController.text,
                  products: totalProducts,
                  pay: totalPay,
                ),
          ),
        );
      });
    } catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving data!")));
    }
  }

  final _dateController = TextEditingController();

  final _sellerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  List<TextEditingController> nameControllers = [];
  List<TextEditingController> carretControllers = [];
  List<TextEditingController> voriControllers = [];
  List<TextEditingController> anaControllers = [];
  List<TextEditingController> rothiControllers = [];
  List<TextEditingController> pointControllers = [];

  List<TextEditingController> payMoneyController = [];

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

  // Save Detalis

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

  // add pay text field
  void addPayField() {
    setState(() {
      TextEditingController payController = TextEditingController();
      payMoneyController.add(payController);

      buyFields.add(
        CustomTextField(
          text: "Money",
          valid: "Enter bill",
          labelText: "Money",
          controller: payController,
          icons: Icons.money,
          keyboard: TextInputType.number,
          onChanged: (value) {
            // ✅ Ensure UI updates when text changes
          },
        ),
      );
    });
  }

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
        title: Text("New Buy", style: TextStyle(fontSize: 20)),
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

                const SizedBox(height: 10),
                CustomTextField(
                  labelText: "Seller Name",
                  text: "",
                  valid: "Enter seller Name",
                  controller: _sellerNameController,
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

                if (payMoneyController.isNotEmpty) ...buyFields,
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
        labels: ['Product', 'Money'],
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
            } else if (label == 'Money') {
              // Handle Money button functionality (Add relevant fields here)
              addPayField();
              // You can add new fields related to money here if required
            }
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    for (var controller in nameControllers) controller.dispose();
    for (var controller in carretControllers) controller.dispose();
    for (var controller in voriControllers) controller.dispose();
    for (var controller in anaControllers) controller.dispose();
    for (var controller in rothiControllers) controller.dispose();
    for (var controller in pointControllers) controller.dispose();
    _dateController.dispose();
    _sellerNameController.dispose();

    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
