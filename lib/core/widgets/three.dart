// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomContainerThree extends StatelessWidget {
  Widget? widget;
  CustomContainerThree({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110.h,
      width: double.maxFinite,
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w)
      ),
      child: widget,
    );
  }
}
