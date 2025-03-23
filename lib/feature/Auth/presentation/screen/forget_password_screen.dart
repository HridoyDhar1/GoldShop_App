import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/Auth/presentation/screen/login_screen.dart';

import 'verificationcode_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  static const String name = "/forget_password";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

final TextEditingController forgetEmailController = TextEditingController();

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> resetPassword() async {
    try {
      if (forgetEmailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your email")),
        );
        return;
      }

      await _auth.sendPasswordResetEmail(email: forgetEmailController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset email sent! Check your inbox.")),
      );

      // Navigate back to login page after sending email
Get.toNamed(LoginScreen.name);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              const Text(
                "Forget Password",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "No worries, we’ll send you reset instructions.",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: CustomTextField(
                  text: "Email",
                  valid: "Enter your email",
                  controller: forgetEmailController,
                  icons: Icons.email,
                  keyboard: TextInputType.text,
                ),
              ),
              const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.black87,
                ),
                onPressed: () {

         resetPassword();
                },
                child: Text("Get Code", style: TextStyle(color: Colors.white)),
              ),
            ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
