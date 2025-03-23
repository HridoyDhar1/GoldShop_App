import 'package:flutter/material.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    super.key,
    required this.textFieldCount,
    required this.nameControllers,
    required this.carretControllers,
    required this.voriControllers,
    required this.anaControllers,
    required this.rothiControllers,
    required this.pointControllers,
  });

  final int textFieldCount;
  final List<TextEditingController> nameControllers;
  final List<TextEditingController> carretControllers;
  final List<TextEditingController> voriControllers;
  final List<TextEditingController> anaControllers;
  final List<TextEditingController> rothiControllers;
  final List<TextEditingController> pointControllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        textFieldCount,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: _buildTextField(
            nameControllers[index],
            carretControllers[index],
            voriControllers[index],
            anaControllers[index],
            rothiControllers[index],
            pointControllers[index],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController nameController,
      TextEditingController carretController,
      TextEditingController voriController,
      TextEditingController anaController,
      TextEditingController rothiController,
      TextEditingController pointController) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _customTextField(nameController, "Name", 200),
            _customTextField(carretController, "Carret", 200),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _customTextField(voriController, "Vori", 100),
            _customTextField(anaController, "Ana", 100),
            _customTextField(rothiController, "Rothi", 100),
            _customTextField(pointController, "Point", 100),
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

