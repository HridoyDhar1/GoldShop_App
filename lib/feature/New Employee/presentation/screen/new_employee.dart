import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/core/utils/responsive.dart';
import 'package:goldshop/feature/EmployeeList/data/model/employee_model.dart';
import 'package:goldshop/feature/EmployeeList/presentation/screen/employee_details.dart';
import 'package:goldshop/feature/EmployeeList/presentation/screen/employee_list.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewEmployeeScreen extends StatefulWidget {
  static const String name = '/new_employee';

  @override
  _NewEmployeeScreenState createState() => _NewEmployeeScreenState();
}

class _NewEmployeeScreenState extends State<NewEmployeeScreen> {
  List<Map<String, dynamic>> employeeList = [];

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child(
        'employee_images/$fileName',
      );
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // Save details
  void _saveAndShowDetails() async {
    String? imageUrl;

    if (_image != null) {
      imageUrl = await uploadImageToFirebase(_image!);
    }

    EmployeeModel employeeModel = EmployeeModel(
      employeeFatherName: fatherNameController.text,
      employeeName: nameController.text,
      address: addressController.text,
      // Add an address field if needed
      phoneNumber: phoneController.text,
      date: birthdayController.text,
      employees: [],
      // Adjust this if needed
      employeeMotherName: motherNameController.text,
      fatherPhoneNumber: fatherPhoneNumberController.text,
      motherPhoneNumber: motherPhoneNumberController.text,
      employeeNidController: nidController.text,
      imageController: imageController.text,
      email: emailController.text,
      monthlyController: monthlyController.text,
    );

    try {
      // Save data to Firestore
      await FirebaseFirestore.instance
          .collection('NewEmployee')
          .add(employeeModel.toMap());
      print("Data Saved Successfully!");

      // Show confirmation message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data Saved Successfully!")));
      // Navigate to SellListScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeListScreen(employeeList: employeeList),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => EmployeeDetailsScreen(
                  nameController: nameController.text,
                  birthdayController: birthdayController.text,
                  phoneController: phoneController.text,
                  emailController: emailController.text,
                  phoneNumberController: phoneNumberController.text,
                  nidController: nidController.text,
                  fatherNameController: fatherNameController.text,
                  motherNameController: motherNameController.text,
                  fatherPhoneNumberController: fatherPhoneNumberController.text,
                  motherPhoneNumberController: motherPhoneNumberController.text,
                  addressController: addressController.text,
                  imageController: _image?.path ?? "",
                  monthlyController: monthlyController.text,
                ),
          ),
        );
      });
    } catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving data!")));
    }
  }

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
                final pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
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
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );
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

  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController fatherPhoneNumberController = TextEditingController();
  TextEditingController motherPhoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController monthlyController = TextEditingController();

  String gender = "Male";
  String countryCode = "+88";

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _image != null
                        ? FileImage(_image!) // Show selected image before upload
                        : (imageController.text.isNotEmpty
                        ? NetworkImage(imageController.text) // Show uploaded image from Firestore
                        : null),
                    child: (_image == null && imageController.text.isEmpty)
                        ? Icon(Icons.person, size: 50, color: Colors.white) // Default icon
                        : null,
                  )
,
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.amber,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Full Name Field
              _buildTextField("Full Name", nameController, icon: Icons.person),

              // Gender & Birthday Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      "Gender",
                      ["Male", "Female", "Other"],
                      gender,
                      (val) {
                        setState(() => gender = val!);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: _buildBirthdayField()),
                ],
              ),
              _buildTextField(
                "Phone Number",
                phoneController,
                icon: Icons.phone,
              ),
              _buildTextField("Address", addressController, icon: Icons.home),

              // Email Field
              _buildTextField("Email", emailController, icon: Icons.email),
              _buildTextField(
                "Father Name",
                fatherNameController,
                icon: Icons.person,
              ),
              _buildTextField(
                "Phone Number",
                fatherPhoneNumberController,
                icon: Icons.phone,
              ),
              _buildTextField(
                "Mother Name",
                motherNameController,
                icon: Icons.person,
              ),
              _buildTextField(
                "Phone Number",
                motherPhoneNumberController,
                icon: Icons.phone,
              ),
              _buildTextField(
                "Nid Number",
                nidController,
                icon: Icons.card_membership,
              ),
              _buildTextField("Monthly", monthlyController, icon: Icons.money),
              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Show success message
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Profile Saved")));

                    // Navigate to home after a short delay to allow the snackbar to be seen
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        _saveAndShowDetails();
                      });
                    });
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill up all fields ")),
                    );
                  }
                },

                child: Text("Save", style: TextStyle(color: Colors.white)),
              ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
    );
  }

  // Common TextField Widget
  Widget _buildTextField(
    String label,

    TextEditingController controller, {
    int maxLines = 1,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Fill up all field";
          }
          return null;
        },
      ),
    );
  }

  // Dropdown Field Widget
  Widget _buildDropdownField(
    String label,
    List<String> items,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: value,
        items:
            items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
