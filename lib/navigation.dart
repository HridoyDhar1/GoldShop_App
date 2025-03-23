import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/feature/Calculator/presentation/screen/calculator.dart';
import 'package:goldshop/feature/HomePage/presentation/screen/home_screen.dart';
import 'package:goldshop/feature/ListScreen/presentation/screen/list_screen.dart';
import 'package:goldshop/feature/Notifications/presentation/screen/notification_screen.dart';

import 'core/widgets/nav_controller.dart';

class CustomNavigationScreen extends StatelessWidget {
  final NavigationController navigationController = Get.put(
    NavigationController(),
  );
  static const String name = '/navigation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return IndexedStack(
          index: navigationController.selectedIndex.value,
          children:  [
            HomeScreen(),
            ListScreen(),
            NotificationScreen(),Calculator(),


          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          margin: EdgeInsets.all(12), // Creates a floating effect
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xff1B353C), // Dark background color
            borderRadius: BorderRadius.circular(30), // Rounded shape
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.list, 1),
              _buildNavItem(Icons.notifications, 2),
              _buildNavItem(Icons.calculate, 3),

            ],
          ),
        );
      }),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => navigationController.updateIndex(index),
      child: Icon(
        icon,
        color:
            navigationController.selectedIndex.value == index
                ? Colors.white
                : Colors.grey,
        size: 28, // Adjusted size
      ),
    );
  }
}
