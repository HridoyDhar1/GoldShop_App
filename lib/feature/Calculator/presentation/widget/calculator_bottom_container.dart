import 'package:flutter/material.dart';

class CustomCalContainer extends StatelessWidget {
  const CustomCalContainer({
    super.key, required this.name,
  });
final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
         name,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
