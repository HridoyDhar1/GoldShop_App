import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/feature/BuyList/presentaion/screen/buy_list.dart';
import 'package:goldshop/feature/EmployeeList/presentation/screen/employee_list.dart';
import 'package:goldshop/feature/HomePage/presentation/wiget/grid_iteam.dart';
import 'package:goldshop/feature/MortgageList/presentation/screen/mortgage_list.dart';
import 'package:goldshop/feature/OtherCost/presentation/screen/other_cost.dart';
import 'package:goldshop/feature/OtherCostList/presentation/screen/other_cost_list.dart';
import 'package:goldshop/feature/PayList/presentation/screen/pay_list.dart';
import 'package:goldshop/feature/ProductList/presentation/screen/product_list.dart';
import 'package:goldshop/feature/SellList/presentation/screen/sell_list.dart';
import 'package:goldshop/feature/workerList/presentation/screen/work_list.dart';


class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  static const String name = "/list_screen";

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<Map<String, dynamic>> myMortgageList = [];
  final List<Map<String, dynamic>> myEmployeeList = [];
  final List<Map<String, dynamic>> mySellList = [];
  final List<Map<String, dynamic>> myBuyList = [];
  final List<Map<String, dynamic>> myPayList = [];
  final List<Map<String, dynamic>> myWorkingList = [];
  final List<Map<String, dynamic>> myCostList = [];
  final List<Map<String, dynamic>> myProductList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.6,
                shrinkWrap: true,
                // Important to prevent rendering issues
                physics: NeverScrollableScrollPhysics(),
                // Prevents nested scrolling issue
                children: [
                  GridItem(
                    title: 'Mortgage List',
                    image: 'assets/icons/Loan.png',
                    ontap: () {
                      Get.to(
                        () => MortgageListScreen(mortgageList: myMortgageList),
                      );
                    },
                  ),
                  GridItem(
                    title: 'Sell List',
                    image: 'assets/icons/Hired.png',
                    ontap: () {
                      Get.to(()=>SellListScreen(salesList: mySellList));
                    },
                  ),
                  GridItem(
                    title: 'Employee List',
                    image: 'assets/icons/headhunting.png',
                    ontap: () {
                      Get.to(()=>EmployeeListScreen(employeeList: myEmployeeList));
                    },
                  ),

                  GridItem(
                    title: 'Buy List',
                    image: 'assets/icons/shopping-list.png',
                    ontap: () {
                      Get.to(()=>BuyListScreen(buyList: myBuyList));
                    },
                  ),
                  GridItem(
                    title: 'Working List',
                    image: 'assets/icons/work.png',
                    ontap: () {
                      Get.to(()=>WorkingListScreen(workList: myWorkingList));
                    },
                  ),
                  GridItem(
                    title: 'Pay List',
                    image: 'assets/icons/send.png',
                    ontap: () {
                      Get.to(()=>PayListScreen(payList: myPayList));
                    },
                  ),


                  GridItem(
                    title: 'Other Cost',
                    image: 'assets/icons/Calculator.png',
                    ontap: () {
                      Get.to(()=>OtherCostScreen());
                    },
                  ),
                  GridItem(
                    title: 'Other Cost List',
                    image: 'assets/icons/Calculator.png',
                    ontap: () { Get.to(()=>OtherCostListScreen(costList: myCostList));},
                  ),
                  GridItem(
                    title: 'Product List',
                    image: 'assets/icons/Product.png',
                    ontap: () {
Get.to(()=>ProductListScreen(productList:myProductList));
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
