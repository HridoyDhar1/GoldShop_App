import 'package:flutter/material.dart';
import 'package:goldshop/core/widgets/button.dart';
import 'package:goldshop/feature/Calculator/presentation/widget/calculator_bottom_container.dart';

class CalculaorScreen extends StatefulWidget {
  const CalculaorScreen({super.key});

  static const String name = '/calculator_screen';

  @override
  State<CalculaorScreen> createState() => _CalculaorScreenState();
}

class _CalculaorScreenState extends State<CalculaorScreen> {
  var voriPrice;
  var mujuri;
  var vori;
  var ana;
  var rothi;
  var point;

  int totalVoriPrice = 0;
  var totalGoldPrice;
  var totalPrice;
  int aa = 16;
  double? perAnaPrice;
  double? perRothiPrice;
  double? perPointPrice;
  var totalAnaPrice;
  var totalRothiPrice;
  var totalPointPrice;

  String? _formateTotalTk;
  String? _formateAna;
  String? _formatePerAna;

  String? _formateRothi;
  String? _formatePerRothi;

  String? _formatePoint;
  String? _formatePerPoint;
  String? _finalTotal;
  final _perVoriController = TextEditingController();
  final _mujuriController = TextEditingController();
  final _voriController = TextEditingController();
  final _anaController = TextEditingController();
  final _rothiController = TextEditingController();
  final _pointController = TextEditingController();

  totalVoriAnaRothiPoint() {
    setState(() {
      voriPrice = _perVoriController.text;
      vori = _voriController.text;
      ana = _anaController.text;
      rothi = _rothiController.text;
      point = _pointController.text;
    });
  }

  totalVoriTk() {
    setState(() {
      var v1 = voriPrice;
      var v2 = vori;
      totalVoriPrice = int.parse(v1) * int.parse(v2);
    });
  }

  anaPrice() {
    setState(() {
      var v3 = voriPrice;
      var v4 = "16";
      perAnaPrice = int.parse(v3) / int.parse(v4);
      _formatePerAna = perAnaPrice!.toStringAsFixed(2);
    });
  }

  totalAnaTk() {
    setState(() {
      var a3 = perAnaPrice;
      var a4 = ana;
      totalAnaPrice = int.parse(a4) * a3!;
      _formateAna = totalAnaPrice.toStringAsFixed(2);
    });
  }

  rothiPrice() {
    setState(() {
      var r1 = perRothiPrice;
      var r2 = "6";
      perRothiPrice = r1! / double.parse(r2);
      _formatePerRothi = perRothiPrice!.toStringAsFixed(2);
    });
  }

  totalRothiTk() {
    setState(() {
      var p1 = perRothiPrice;
      var p2 = rothi;
      totalRothiPrice = double.parse(p2) * p1!;
      _formateRothi = totalRothiPrice.toStringAsFixed(2);
    });
  }

  pointPrice() {
    setState(() {
      var p3 = perPointPrice;
      var p4 = "10";
      perPointPrice = double.parse(p4) * p3!;
      _formatePerPoint = perPointPrice!.toStringAsFixed(2);
    });
  }

  totalPointTk() {
    setState(() {
      var p5 = perPointPrice;
      var p6 = point;
      totalPointPrice = double.parse(p6) * p5!;
      _formatePoint = totalPointPrice.toStringAsFixed(2);
    });
  }

  goldPrice() {
    setState(() {
      totalGoldPrice =
          totalVoriPrice + totalAnaPrice + totalRothiPrice + totalPointPrice;
      _formateTotalTk = totalGoldPrice.toStringAsFixed(2);
    });
  }

  total() {
    setState(() {
      var mujuriPrice = _mujuriController.text;
      totalPrice = totalGoldPrice + double.parse(mujuriPrice);
      _finalTotal = totalPrice.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCalContainer(name: 'Per Vori Price'),
                    const SizedBox(height: 10),
                    CustomCalContainer(name: 'Mujuri'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  buildRowInput("Vori", _voriController),
                  const SizedBox(height: 20),
                  buildRowInput("Ana", _anaController),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Rothi",
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: _rothiController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "$_formatePerRothi X $rothi = $_formatePoint Taka",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Point",
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: _pointController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "$_formatePerRothi X $point = $_formatePoint Taka",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),

              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'স্বর্ণের দাম',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "$_formateTotalTk Taka".toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('মজুরি', style: TextStyle(fontSize: 20)),
                          Text(
                            "${_mujuriController.text} Taka".toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('মোট', style: TextStyle(fontSize: 20)),
                          Text(
                            "$_finalTotal Taka".toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
         Row(children: [
           SizedBox(width: 150,child: CustomButtonTwo(text: "Calculate", onAction: (){

         totalVoriAnaRothiPoint();
             totalVoriTk();
             anaPrice();
             totalAnaTk();
             rothiPrice();
             totalRothiTk();
             pointPrice();
             totalPointTk();
             goldPrice();
             total();


           }),)
         ],)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRowInput(String label, TextEditingController controller) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 20, color: Colors.black87)),
        const SizedBox(width: 30),
        Flexible(
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          "$voriPrice X $vori = $totalVoriPrice Taka",
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
