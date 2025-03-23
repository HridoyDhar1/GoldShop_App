import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/core/widgets/custom_datapicker.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/PayList/data/pay_model.dart';
import 'package:goldshop/feature/PayList/presentation/screen/pay_list_details.dart';

class NewPayScreen extends StatefulWidget {
  const NewPayScreen({super.key});

  static const String name = "new_pay";

  @override
  State<NewPayScreen> createState() => _NewPayScreenState();
}

class _NewPayScreenState extends State<NewPayScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  List<Map<String, dynamic>> payList = [];
  List<Map<String, String>> totalPay = [];

  // save details
  void _saveAndShowDetails() async{
    PayModel payModel = PayModel(
      name: _nameController.text,
      phoneNumber: _phoneNumberController.text,
      date: _dateController.text,
      paying: totalPay,
      money: _moneyController.text,
    );
    try{

      // Save data to Firestore
      await FirebaseFirestore.instance.collection('NewPay').add(
          payModel.toMap());
      print("Data Saved Successfully!");

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Saved Successfully!")),
      );
      Future.delayed(Duration(seconds: 2), () {
        // Navigate to SellDetailsScreen and remove SellListScreen from the stack
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => PayDetailsScreen(
              phoneNumber: _phoneNumberController.text,
              date: _dateController.text,
              name: _nameController.text,
              payingList: totalPay,
              money: double.tryParse(_moneyController.text) ?? 0.0,

            ),
          ),
        );
      }

      );
    }catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving data!")),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Pay"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
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
                  labelText: "Full Name",
                  text: "",
                  valid: "Enter full  Name",
                  controller: _nameController,
                  icons: Icons.person,
                  keyboard: TextInputType.text,
                ),

                CustomTextField(
                  labelText: "Phone Number",
                  text: "",
                  valid: "Enter phone Number",
                  controller: _phoneNumberController,
                  icons: Icons.phone,
                  keyboard: TextInputType.text,
                ),
                CustomTextField(
                  labelText: "Money",
                  text: "",
                  valid: "Money",
                  controller: _moneyController,
                  icons: Icons.money,
                  keyboard: TextInputType.text,
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
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
                        print("object");
                        _saveAndShowDetails();
                      });
                    },

                    child: Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
