import 'package:flutter/material.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key, required this.onTaps});
final Function(String) onTaps;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search by Name",
          suffixIcon:  Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: onTaps,
      ),
    ));
  }
}
