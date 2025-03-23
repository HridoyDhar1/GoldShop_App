import 'package:flutter/material.dart';


class CustomElevatedButton extends StatelessWidget {

  const CustomElevatedButton({
    super.key, required this.text, required this.hSize, required this.vSize, required this.onPressed, required this.colors,
  });
  final String text;
  final double hSize;
  final double vSize;
  final VoidCallback onPressed;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    
    return ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: hSize,vertical: vSize),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor: colors),
        onPressed: (){}, child: Text(text,style: TextStyle(color: Colors.white),));
  }
}