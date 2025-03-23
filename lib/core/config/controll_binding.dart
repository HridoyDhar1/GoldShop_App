
import 'package:get/get.dart';

import '../widgets/nav_controller.dart';


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());



  }
}