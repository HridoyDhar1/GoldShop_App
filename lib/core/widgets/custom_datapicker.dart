import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onDateSelected; // Made optional

  DatePickerTextField({required this.controller, this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: const Icon(Icons.calendar_today),
          hintText: 'Date',
        ),
        readOnly: true,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              DateTime selectedDate = DateTime.now();
              return SizedBox(
                height: 250,
                child: Column(
                  children: [
                    Expanded(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime pickedDate) {
                          selectedDate = pickedDate;
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String formattedDate = DateFormat("dd-MM-yyyy").format(selectedDate);
                        controller.text = formattedDate;

                        if (onDateSelected != null) {
                          onDateSelected!(formattedDate); // Call only if provided
                        }

                        Navigator.pop(context);
                      },
                      child: const Text("Confirm"),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
