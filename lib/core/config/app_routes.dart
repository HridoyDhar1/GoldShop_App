import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/core/config/controll_binding.dart';
import 'package:goldshop/feature/AddProductAndMoney/presentation/screen/product_and_money.dart';
import 'package:goldshop/feature/Calculator/presentation/screen/calculator.dart';
import 'package:goldshop/feature/GiveWork/presentation/screen/give_work.dart';
import 'package:goldshop/feature/HomePage/presentation/screen/home_screen.dart';
import 'package:goldshop/feature/ListScreen/presentation/screen/list_screen.dart';
import 'package:goldshop/feature/New%20Employee/presentation/screen/new_employee.dart';
import 'package:goldshop/feature/NewBuy/presentation/new_buy.dart';
import 'package:goldshop/feature/NewMortgage/presentation/screen/new_mortgage.dart';
import 'package:goldshop/feature/NewSell/presentation/screen/new_sell.dart';
import 'package:goldshop/feature/OtherCost/presentation/screen/other_cost.dart';
import 'package:goldshop/feature/Pay/presentation/screen/new_pay.dart';
import 'package:goldshop/feature/ProfileDetails/presentation/screen/create_profile.dart';
import 'package:goldshop/feature/SellList/presentation/screen/sell_list.dart';
import 'package:goldshop/navigation.dart';


import '../../feature/Auth/presentation/screen/forget_password_screen.dart';
import '../../feature/Auth/presentation/screen/login_screen.dart';
import '../../feature/Auth/presentation/screen/singup_screen.dart';
import '../../feature/Auth/presentation/screen/splash_screen.dart';
import '../../feature/Auth/presentation/screen/verificationcode_screen.dart';

class GoldShop extends StatelessWidget {
  const GoldShop({super.key});
static GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      initialBinding: ControllerBinder(),
      initialRoute:"/splash_screen",

      debugShowCheckedModeBanner: false,
     getPages: [
       GetPage(
           name: '/splash_screen', page:()=> SplashScreen(),
       ),
       GetPage(
         name: '/navigation', page:()=> CustomNavigationScreen(),
       ),
       GetPage(
         name: '/login', page:()=> LoginScreen(),
       ),
       GetPage(
         name: '/signup', page:()=> SignupScreen(),
       ),
       GetPage(
         name: '/create_profile', page:()=> CreateProfileScreen(),
       ),
       GetPage(
         name: '/home_screen', page:()=> HomeScreen(),
       ),
       GetPage(
         name: '/forget_password', page:()=> ForgetPasswordScreen(),
       ),
       GetPage(
         name: '/verification_screen', page:()=> VerificationCodeScreen(),
       ),
       GetPage(
         name: '/calculator', page:()=> Calculator(),
       ),
       GetPage(
         name: '/list_screen', page:()=> ListScreen(),
       ),

       GetPage(
         name: '/new_sell', page:()=> NewSellScreen(),
       ),
       GetPage(
         name: '/sell_list', page:()=> SellListScreen(salesList: [],),
       ),

       GetPage(
         name: '/new_mortgage', page:()=> NewMortgageScreen()),

       GetPage(
           name: '/new_employee', page:()=>NewEmployeeScreen()),
       GetPage(
           name: '/give_work', page:()=>GiveWorkScreen()),
       GetPage(
           name: '/new_pay', page:()=>NewPayScreen()),
       GetPage(
           name: '/new_buy', page:()=>NewBuyScreen()),
       GetPage(
           name: '/add_product_money', page:()=>AddProductAndMoney()),
       GetPage(
           name: '/other_cost', page:()=>OtherCostScreen()),

     ]
    );
  }
}
