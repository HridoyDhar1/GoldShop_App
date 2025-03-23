
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<String> labels;
  final Function(String) onPressed; // Callback for each label

  const CustomFloatingActionButton({
    Key? key,
    required this.isExpanded,
    required this.onToggle,
    required this.labels,
    required this.onPressed, // Accept callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Mini FABs appearing when expanded
        Positioned(
          bottom: 80,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isExpanded)
                ...labels.map((label) {
                  return Column(
                    children: [
                      _buildMiniFab(label),
                      SizedBox(height: 12),
                    ],
                  );
                }).toList(),
            ],
          ),
        ),
        // Main Floating Action Button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: onToggle,
            backgroundColor: Colors.black87,
            child: Icon(isExpanded ? Icons.close : Icons.add, size: 32, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // Mini FAB Builder
  Widget _buildMiniFab(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          mini: true,
          onPressed: () => onPressed(label), // Trigger the callback on mini FAB press
          backgroundColor: Colors.black87,
          child: Icon(Icons.circle, size: 20, color: Colors.white),
        ),
      ],
    );
  }
}
