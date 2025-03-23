import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/core/widgets/custom_datapicker.dart';
import 'package:goldshop/core/widgets/custom_floatingaction_button.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/NewSell/presentation/widget/product_text_field.dart';
import 'package:goldshop/feature/SellList/data/model/sell_model.dart';
import 'package:goldshop/feature/SellList/presentation/screen/sell_details_screen.dart';
import 'package:goldshop/feature/SellList/presentation/screen/sell_list.dart';


class NewSellScreen extends StatefulWidget {
  const NewSellScreen({super.key});

  static const String name = "new_sell";

  @override
  State<NewSellScreen> createState() => _NewSellScreenState();
}

class _NewSellScreenState extends State<NewSellScreen> {
  List<Widget> mujuriFields = [];
  List<Widget> discountFields = [];
  List<Widget> payFields = [];
  List<Map<String, dynamic>> sellList = [];

  bool isExpanded = false;
  double totalPrice = 0.0; // Variable to store total price

  double discount = 0.0;
  double finalPrice = 0.0;
  double mujuri = 0.0;
  double pay = 0.0;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  // Save Details


  void _saveAndShowDetails() async {
    print("Button Clicked");
    _addProductToList(); // Ensure product list is updated before navigation

    // Create a new SellModel instance
    SellModel newSell = SellModel(
      shopName: _shopNameController.text,
      customerName: _customerNameController.text,
      address: _addressController.text,
      phoneNumber: _phoneNumberController.text,
      date: _dateController.text,
      products: totalProducts,
      totalPrice: totalPrice,
      mujuri: mujuri,
      discount: discount,
      pay: pay,
      finalPrice: finalPrice,
    );

    try {
      // Save data to Firestore
      await FirebaseFirestore.instance.collection('NewSell').add(newSell.toMap());
      print("Data Saved Successfully!");

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Saved Successfully!")),
      );

      // Navigate to SellListScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SellListScreen(salesList: sellList),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        // Navigate to SellDetailsScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SellDetailsScreen(
              shopName: _shopNameController.text,
              customerName: _customerNameController.text,
              address: _addressController.text,
              phoneNumber: _phoneNumberController.text,
              date: _dateController.text,
              products: totalProducts,
              totalPrice: totalPrice,
              mujuri: mujuri,
              discount: discount,
              pay: pay,
              finalPrice: finalPrice,
            ),
          ),
        );
      });
    } catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving data!")),
      );
    }
  }

  final _dateController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _perVoriPriceController = TextEditingController();

  List<TextEditingController> nameControllers = [];
  List<TextEditingController> carretControllers = [];
  List<TextEditingController> voriControllers = [];
  List<TextEditingController> anaControllers = [];
  List<TextEditingController> rothiControllers = [];
  List<TextEditingController> pointControllers = [];
  List<TextEditingController> mujuriMoneyController = [];
  List<TextEditingController> payMoneyController = [];
  List<TextEditingController> discountMoneyController = [];

  int textFieldCount = 1;
  List<Map<String, String>> totalProducts =[]; // List to store entered products
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

  /// Mujuri field
  void addMujuriField() {
    setState(() {
      TextEditingController newController = TextEditingController();
      mujuriMoneyController.add(newController);

      mujuriFields.add(
        CustomTextField(
          text: "Mujuri",
          valid: "Enter Mujuri",
          labelText: "Mujuri",
          controller: newController,
          icons: Icons.money,
          keyboard: TextInputType.number,
          onChanged: (value) {
            setState(() {
              mujuri = double.tryParse(value) ?? 0.0;
              _calculateFinalPrice();
            }); // ✅ Ensure UI updates when text changes
          },
        ),
      );
    });
  }

  // add pay text field
  void addPayField() {
    setState(() {
      TextEditingController payController = TextEditingController();
      payMoneyController.add(payController);

      payFields.add(
        CustomTextField(
          text: "Pay",
          valid: "Enter bill",
          labelText: "Pay",
          controller: payController,
          icons: Icons.money,
          keyboard: TextInputType.number,
          onChanged: (value) {
            setState(() {
              pay = double.tryParse(value) ?? 0.0;
              _calculateFinalPrice();
            }); // ✅ Ensure UI updates when text changes
          },
        ),
      );
    });
  }

  // add discount text field
  void addDiscountField() {
    setState(() {
      TextEditingController discountController = TextEditingController();
      discountMoneyController.add(discountController);

      discountFields.add(
        CustomTextField(
          text: "Discount",
          valid: "Enter discount",
          labelText: "Discount",
          controller: discountController,
          icons: Icons.money,
          keyboard: TextInputType.number,
          onChanged: (value) {
            setState(() {
              discount = double.tryParse(value) ?? 0.0;
              _calculateFinalPrice();
            }); // ✅ Ensure UI updates when text changes
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

    // After all conversions, calculate total price
    double perVoriPrice = double.tryParse(_perVoriPriceController.text) ?? 0;
    _calculateTotalGoldPrice(perVoriPrice);
  }

  // Calculate Total Gold Price
  void _calculateTotalGoldPrice(double perVoriPrice) {
    // Step 1: Calculate unit prices
    double perAnaPrice = perVoriPrice / 16; // 1 Ana price
    double perRothiPrice = perAnaPrice / 10; // 1 Rothi price
    double perPointPrice = perRothiPrice / 10; // 1 Point price

    // Step 2: Compute total price
    totalPrice =
        (totalVori * perVoriPrice) +
        (totalAna * perAnaPrice) +
        (totalRothi * perRothiPrice) +
        (totalPoint * perPointPrice);
    _calculateFinalPrice();
  }

  void _calculateFinalPrice() {
    double calculatedFinalPrice = totalPrice + mujuri - (pay + discount);

    setState(() {
      finalPrice = calculatedFinalPrice;
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
        title: Text("New Sell", style: TextStyle(fontSize: 20)),
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
                      labelText: "Vori Price",
                      text: "",
                      valid: "Enter vori price",
                      controller: _perVoriPriceController,
                      icons: Icons.money,
                      keyboard: TextInputType.text,
                    ),
                  ),
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
                if (mujuriMoneyController.isNotEmpty) ...mujuriFields,
                if (discountMoneyController.isNotEmpty) ...discountFields,
                if (payMoneyController.isNotEmpty) ...payFields,
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

                            double? userPrice = double.tryParse(
                              _perVoriPriceController.text,
                            );
                            if (userPrice != null) {
                              _calculateTotalGoldPrice(userPrice);
                            }
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
                                    SizedBox(height: 20),
                                    Text(
                                      "Total Gold Price: \$${totalPrice.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Total Price: \$${finalPrice}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
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
        labels: ['Product', 'Mujuri', 'Discount', 'Pay'],
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
            } else if (label == 'Mujuri') {
              // Handle Money button functionality (Add relevant fields here)
              addMujuriField();
              // You can add new fields related to money here if required
            } else if (label == 'Discount') {
              // Handle Money button functionality (Add relevant fields here)
              addDiscountField();
              // You can add new fields related to money here if required
            } else if (label == 'Pay') {
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
    _shopNameController.dispose();
    _customerNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
