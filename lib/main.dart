

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/feature/Auth/presentation/controllers/auth_controller.dart';



import 'core/config/app_routes.dart';
void main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(GoldShop());
}
