import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/core/utils/responsive.dart';
import 'package:goldshop/core/widgets/custom_elevated_button.dart';
import 'package:goldshop/feature/HomePage/presentation/screen/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateProfileScreen extends StatefulWidget {
  static const String name = '/create_profile';

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  // Function to select image from camera or gallery
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(text: "Radha Krishna");
  TextEditingController birthdayController = TextEditingController(text: "24-09-1998");
  TextEditingController phoneController = TextEditingController(text: "019365235");
  TextEditingController emailController = TextEditingController(text: "support@gmail.com");
  TextEditingController locationController = TextEditingController(text: "Los Angeles");
  TextEditingController bioController = TextEditingController(
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.");

  String gender = "Male";
  String countryCode = "+88";

  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture Selection
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    backgroundColor: Colors.grey.shade300,
                    child: _image == null ? Icon(Icons.person, size: 50, color: Colors.white) : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Full Name Field
              _buildTextField("Full Name", nameController),

              // Gender & Birthday Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField("Gender", ["Male", "Female", "Other"], gender, (val) {
                      setState(() => gender = val!);
                    }),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildBirthdayField(),
                  ),
                ],
              ),

              // Phone Number
              Row(
                children: [


                  Expanded(child: _buildTextField("Phone Number", phoneController)),
                ],
              ),

              // Email Field
              _buildTextField("Email", emailController),



              SizedBox(height: 20),

              // Save Button

        CustomElevatedButton(
          text: "Save",
          hSize: responsive.getButtonPaddingH(),
          vSize: responsive.getButtonPaddingV(),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Profile Saved")),
              );

              // Navigate to home after a short delay to allow the snackbar to be seen
              Future.delayed(Duration(seconds: 1), () {
                Get.toNamed(HomeScreen.name);
              });

            } else {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please fill up all fields correctly")),
              );
            }
          },
          colors: Colors.black87,
        )



        ],
          ),
        ),
      ),
    );
  }

  // Function to Open Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        birthdayController.text = formattedDate;
      });
    }
  }

  // Birthday Field with Date Picker
  Widget _buildBirthdayField() {
    return TextFormField(
      controller: birthdayController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Birthday",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
    );
  }

  // Common TextField Widget
  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }

  // Dropdown Field Widget
  Widget _buildDropdownField(String label, List<String> items, String value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
