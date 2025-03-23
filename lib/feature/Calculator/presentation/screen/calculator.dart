import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _perVoriController = TextEditingController();
  final _mujuriController = TextEditingController();
  final _voriController = TextEditingController();
  final _anaController = TextEditingController();
  final _rothiController = TextEditingController();
  final _pointController = TextEditingController();

  double totalVoriPrice = 0;
  double perAnaPrice = 0, perRothiPrice = 0, perPointPrice = 0;
  double totalGoldPrice = 0, totalPrice = 0;
  String formattedTotalTk = "0", finalTotal = "0";

  void calculate() {
    setState(() {
      // Fetch values
      double perVori = double.tryParse(_perVoriController.text) ?? 0;
      double vori = double.tryParse(_voriController.text) ?? 0;
      double ana = double.tryParse(_anaController.text) ?? 0;
      double rothi = double.tryParse(_rothiController.text) ?? 0;
      double point = double.tryParse(_pointController.text) ?? 0;
      double mujuri = double.tryParse(_mujuriController.text) ?? 0;

      // Gold price calculations
      totalVoriPrice = perVori * vori;
      perAnaPrice = perVori / 16;
      perRothiPrice = perAnaPrice / 6;
      perPointPrice = perAnaPrice / 10;

      double totalAnaPrice = ana * perAnaPrice;
      double totalRothiPrice = rothi * perRothiPrice;
      double totalPointPrice = point * perPointPrice;

      totalGoldPrice = totalVoriPrice + totalAnaPrice + totalRothiPrice + totalPointPrice;
      totalPrice = totalGoldPrice + mujuri;

      formattedTotalTk = totalGoldPrice.toStringAsFixed(2);
      finalTotal = totalPrice.toStringAsFixed(2);
    });

    showCalculationDialog();
    // Clear all input fields after calculation
    _perVoriController.clear();
    _mujuriController.clear();
    _voriController.clear();
    _anaController.clear();
    _rothiController.clear();
    _pointController.clear();
  }

  void showCalculationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Calculation Results"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResultRow("স্বর্ণের দাম", "$formattedTotalTk টাকা"),
              _buildResultRow("মজুরি", "${_mujuriController.text} টাকা"),
              _buildResultRow("মোট", "$finalTotal টাকা"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(

          children: [
            const SizedBox(height: 100,),
            _buildTextField(_perVoriController, "Per Vori Price",),
            _buildTextField(_mujuriController, "Mujuri"),
            _buildTextField(_voriController, "Vori"),
            _buildTextField(_anaController, "Ana"),
            _buildTextField(_rothiController, "Rothi"),
            _buildTextField(_pointController, "Point"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                backgroundColor: Colors.black87,
              ),
              child: const Text('Calculate',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(

        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
