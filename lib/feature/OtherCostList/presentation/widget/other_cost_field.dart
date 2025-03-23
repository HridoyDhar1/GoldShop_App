import 'package:flutter/material.dart';

class OtherCostField extends StatelessWidget {
  const OtherCostField({
    super.key,
    required this.textFieldCount,
    required this.nameControllers,
    required this.moneyControllers,

  });

  final int textFieldCount;
  final List<TextEditingController> nameControllers;
  final List<TextEditingController> moneyControllers;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        textFieldCount,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: _buildTextField(
            nameControllers[index],
            moneyControllers[index]

          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController nameController,
      TextEditingController moneyController,
    ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _customTextField(nameController, "Name", 200),
            _customTextField(moneyController, "Money", 200),
          ],
        ),

      ],
    );
  }

  Widget _customTextField(
      TextEditingController controller, String label, double width) {
    return SizedBox(
      height: 60,
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

