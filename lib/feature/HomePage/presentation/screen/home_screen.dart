
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/feature/AddProductAndMoney/presentation/screen/product_and_money.dart';
import 'package:goldshop/feature/Auth/presentation/screen/login_screen.dart';
import 'package:goldshop/feature/GiveWork/presentation/screen/give_work.dart';
import 'package:goldshop/feature/HomePage/presentation/controller/calculationa_controller.dart';
import 'package:goldshop/feature/HomePage/presentation/wiget/grid_iteam.dart';
import 'package:goldshop/feature/IcomeDashboard/presentation/screen/icome_dashboard.dart';
import 'package:goldshop/feature/New%20Employee/presentation/screen/new_employee.dart';
import 'package:goldshop/feature/NewBuy/presentation/new_buy.dart';
import 'package:goldshop/feature/NewMortgage/presentation/screen/new_mortgage.dart';
import 'package:goldshop/feature/NewSell/presentation/screen/new_sell.dart';
import 'package:goldshop/feature/Pay/presentation/screen/new_pay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FinancialController financialController = Get.put(FinancialController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Obx(() => CustomAppBar(finalMoney: '৳ ${financialController.finalMoney.value}')),
            ],
              // Positioned(
              //   bottom: -100,
              //   left: 20,
              //   right: 20,
              //   child: Column(
              //     children: [
              //       Container(
              //         height: 150,
              //         width: 350,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(30),
              //           color: Color(0xffF7FAFF),
              //         ),
              //
              //         child: Column(
              //           children: [
              //             const SizedBox(height: 50),
              //             Text(
              //               textAlign: TextAlign.center,
              //               " 4560000 TK",
              //               style: TextStyle(
              //                 fontSize: 25,
              //                 color: Colors.black87,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            // ],
          ),
          const SizedBox(height: 60),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.6,
                // Try increasing this value for better height
                children: [
                  GridItem(
                    title: 'Income',
                    image: 'assets/icons/Income.png',
                    ontap: () {
                      Get.to(() => IncomeDashboardScreen(
                        addMoney: financialController.addMoney.value,
                        totalSell: financialController.totalSell.value,
                        totalMortgage: financialController.totalMortgage.value,
                        otherCost: financialController.otherCost.value,
                        totalBuy: financialController.totalBuy.value,
                        sendMoney: financialController.sendMoney.value,
                        mortgagePay: financialController.mortgagePay.value,
                        money: financialController.finalMoney.value,
                      ));
                    },
                  ),

                  GridItem(
                    title: 'Sell',
                    image: 'assets/icons/Sell.png',
                    ontap: () {
                      Get.toNamed(NewSellScreen.name);
                    },
                  ),
                  GridItem(
                    title: 'Mortgage ',
                    image: 'assets/icons/Employee-2.png',
                    ontap: () {
                      Get.toNamed(NewMortgageScreen.name);
                    },
                  ),
                  GridItem(
                    title: 'Employee',
                    image: 'assets/icons/Employee.png',
                    ontap: () {
                      Get.toNamed(NewEmployeeScreen.name);
                    },
                  ),

                  GridItem(
                    title: 'Pay',
                    image: 'assets/icons/pay.png',
                    ontap: () {
                      Get.toNamed(NewPayScreen.name);
                    },
                  ),
                  GridItem(
                    title: 'Give Work',
                    image: 'assets/icons/work-time.png',
                    ontap: () {
                      Get.toNamed(GiveWorkScreen.name);
                    },
                  ),

                  GridItem(
                    title: 'Buy',
                    image: 'assets/icons/buy.png',
                    ontap: () {
                      Get.toNamed(NewBuyScreen.name);
                    },
                  ),
                  GridItem(
                    title: 'Add Product',
                    image: 'assets/icons/Product.png',
                    ontap: () {
                      Get.toNamed(AddProductAndMoney.name);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, required this.finalMoney});
  final String finalMoney;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isBalanceVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logoutUser(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 450,
      decoration: BoxDecoration(
        color: Color(0xff1B353C),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(

            children: [
              const SizedBox(width: 20),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 24, color: Colors.black),
              ),
              const SizedBox(width: 50),

              Text(
                "Govindas Gold Shop",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 60),
              IconButton(
                onPressed: () => logoutUser(context),
                icon: Icon(Icons.logout, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                _isBalanceVisible = !_isBalanceVisible; // Toggle visibility
              });
            },
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  _isBalanceVisible ? "৳ ${widget.finalMoney}" : "Tap to check balance",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          // Meye bole gali toh dite parteche na tay bolteche rki classmate biye korso
        ],
      ),
    );
  }
}