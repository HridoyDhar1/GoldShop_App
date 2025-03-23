// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class CustomButtonTwo extends StatefulWidget {
  String text;
  final Function onAction;
  CustomButtonTwo({Key? key, required this.text, required this.onAction})
      : super(key: key);

  @override
  State<CustomButtonTwo> createState() => _CustomButtonTwoState();
}

class _CustomButtonTwoState extends State<CustomButtonTwo> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() => _value = true);
        await Future.delayed(const Duration(seconds: 1));
        widget.onAction();
        setState(() => _value = false);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(5)),
        height: 45,
        width: double.maxFinite,
        child: _value == false
            ? Center(
            child: Text(widget.text,
                style: const TextStyle(color: Colors.white)))
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please wait",
                style: TextStyle(color: Colors.white)),
            const SizedBox(width: 10),
            Transform.scale(
                scale: 0.4,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
