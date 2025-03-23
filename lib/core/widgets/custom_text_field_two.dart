// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';




class CustomTextFieldTwo extends StatelessWidget {
  String childText;
  var keyboardType;
  Icon prefixIcon;
  TextEditingController controller;

  CustomTextFieldTwo({
    Key? key,
    required this.childText,
    required this.keyboardType,
    required this.controller,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field is empty';
          }
          return null;
        },
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: InputBorder.none,
          // fillColor: AppColor.textFieldBgColor,
          // filled: true,
          hintText: childText,
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}