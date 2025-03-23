// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:goldshop/core/widgets/custom_text_field.dart';
// import 'package:goldshop/feature/OtherCostList/data/othercost_model.dart';
// import 'package:goldshop/feature/OtherCostList/presentation/screen/other_cost_details.dart';
//
// class OtherCostScreen extends StatefulWidget {
//   const OtherCostScreen({super.key});
//
//   static const String name = "other_cost";
//
//   @override
//   State<OtherCostScreen> createState() => _OtherCostScreenState();
// }
//
// class _OtherCostScreenState extends State<OtherCostScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _moneyController = TextEditingController();
//
//   List<Map<String, dynamic>> costList = [];
//
//   double totalPrice = 0.0;
//
//   // Save details and navigate
//   void _saveAndShowDetails() async {
//     String name = _nameController.text.trim();
//     double money = double.tryParse(_moneyController.text.trim()) ?? 0.0;
//
//     if (name.isNotEmpty && money > 0) {
//       setState(() {
//         costList.add({"name": name, "money": money});
//         _calculateTotalCost();
//       });
//
//       try {
//         // ✅ Create an instance of OtherCostModel
//         OtherCostModel othercostModel = OtherCostModel(
//           name: _nameController.text,
//           money: _moneyController.text,
//         );
//
//         // ✅ Save data to Firestore
//         await FirebaseFirestore.instance
//             .collection('OtherCost')
//             .add(othercostModel.toMap());
//
//         print("Data Saved Successfully!");
//
//         // ✅ Show confirmation message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Data Saved Successfully!")),
//         );
//
//         // ✅ Navigate to details screen after saving
//         Future.delayed(const Duration(seconds: 1), () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => OtherCostDetailsScreen(
//                 name: name,
//                 costs: costList,
//                 totalPrice: totalPrice,
//               ),
//             ),
//           );
//         });
//       } catch (e) {
//         print("Error saving data: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error saving data! $e")),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter valid details")),
//       );
//     }
//   }
//
//
//   // Calculate Total Cost
//   void _calculateTotalCost() {
//     totalPrice = costList.fold(0.0, (sum, item) => sum + (item["money"] as double));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Other Cost")),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 100),
//                 CustomTextField(
//                   labelText: "Full Name",
//                   text: "",
//                   valid: "Enter full Name",
//                   controller: _nameController,
//                   icons: Icons.person,
//                   keyboard: TextInputType.text,
//                 ),
//                 CustomTextField(
//                   labelText: "Money",
//                   text: "",
//                   valid: "Enter Money",
//                   controller: _moneyController,
//                   icons: Icons.money,
//                   keyboard: TextInputType.number,
//                 ),
//                 const SizedBox(height: 50),
//                 Center(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       backgroundColor: Colors.black87,
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     ),
//                     onPressed: _saveAndShowDetails,
//                     child: Text("Save", style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/OtherCostList/data/othercost_model.dart';
import 'package:goldshop/feature/OtherCostList/presentation/screen/other_cost_details.dart';

class OtherCostScreen extends StatefulWidget {
  const OtherCostScreen({super.key});

  static const String name = "other_cost";

  @override
  State<OtherCostScreen> createState() => _OtherCostScreenState();
}

class _OtherCostScreenState extends State<OtherCostScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  List<Map<String, dynamic>> costList = [];
  double totalPrice = 0.0;

  // Save details and navigate
  void _saveAndShowDetails() async {
    String name = _nameController.text.trim();
    double money = double.tryParse(_moneyController.text.trim()) ?? 0.0;

    if (name.isNotEmpty && money > 0) {
      try {
        // ✅ Convert input to correct data types
        OtherCostModel othercostModel = OtherCostModel(
          name: _nameController.text,
          money: money.toString(),
        );

        // ✅ Save data to Firestore
        await FirebaseFirestore.instance
            .collection('OtherCost')
            .add(othercostModel.toMap());

        setState(() {
          costList.add({"name": name, "money": money.toDouble()});
          _calculateTotalCost();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data Saved Successfully!")),
        );

        // ✅ Navigate to details screen
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtherCostDetailsScreen(
                name: name,
                costs: costList,
                totalPrice: totalPrice,
              ),
            ),
          );
        });
      } catch (e) {
        print("Error saving data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving data! $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid details")),
      );
    }
  }

  // Calculate Total Cost
  void _calculateTotalCost() {
    totalPrice = costList.fold(0.0, (sum, item) => sum + (item["money"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Other Cost")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                CustomTextField(
                  labelText: "Full Name",
                  text: "",
                  valid: "Enter full Name",
                  controller: _nameController,
                  icons: Icons.person,
                  keyboard: TextInputType.text,
                ),
                CustomTextField(
                  labelText: "Money",
                  text: "",
                  valid: "Enter Money",
                  controller: _moneyController,
                  icons: Icons.money,
                  keyboard: TextInputType.number,
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black87,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                    onPressed: _saveAndShowDetails,
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
