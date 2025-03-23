import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 450,
      color: Colors.black87,
      child: Row(

        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 24, color: Colors.black),
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const SizedBox(height: 70,),
              Text(
                "Govindas Gold Shop",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                "0189745738",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),

        ],
      ),
    );
  }}