import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
final String image;
final VoidCallback ontap;
  const GridItem({
    required this.title,
  required this.image, required this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: AspectRatio(
        aspectRatio: 1.3, // Adjust for proper height
        child: Card(

          color: Color(0xffF7FAFF),
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,width: 50,child: Image.asset(image),),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
