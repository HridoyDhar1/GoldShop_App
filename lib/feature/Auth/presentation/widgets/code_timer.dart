import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeTimer extends StatelessWidget {
  const CodeTimer({
    super.key,
    required RxInt remainingTime,
  }) : _remainingTime = remainingTime;

  final RxInt _remainingTime;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_remainingTime.value > 0) {
        return RichText(
          text: TextSpan(
            text: 'This code will expire in ',
            style: const TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: '${_remainingTime.value}s',
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      } else {
        return const Text(
          "Code expired. Please request a new code.",
          style: TextStyle(color: Colors.redAccent),
        );
      }
    });
  }
}