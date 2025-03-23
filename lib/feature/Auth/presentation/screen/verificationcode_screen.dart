
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/core/widgets/custom_elevated_button.dart';
import 'package:goldshop/feature/HomePage/presentation/screen/home_screen.dart';

import 'dart:async';

import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../../core/constant/app_constant.dart';
import '../widgets/code_timer.dart';
import 'login_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});
  static const String name = "/verification_screen";

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    email = Get.arguments?['email'];
  }

  // Verify Reset Code
  Future<void> verifyResetCode() async {
    try {
      String resetCode = pinController.text.trim();

      // Assuming that the code received in the email is equivalent to the verification code
      // For this, you'd typically implement a custom email verification system if needed.
      // Firebase Auth doesn't send a custom PIN but uses the reset link.

      await _auth.confirmPasswordReset(
          code: resetCode, newPassword: "newPasswordHere");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset successful!")),
      );

      // Redirect to login page
      Get.toNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  final TextEditingController pinController = TextEditingController();

  final RxInt _remainingTime = AppConstants.reSendOtpTimeOutInSec.obs;
  final RxBool _enableResendCodeButton = false.obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _remainingTime.value = AppConstants.reSendOtpTimeOutInSec;
    _enableResendCodeButton.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        _timer?.cancel();
        _enableResendCodeButton.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                "Enter Your Verification Code",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sed varius eget arcu posuere varius tincidunt lectus. Eros justo sollicitudin egestas lorem ipsum. Bibendum.",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              PinCodeTextField(
                controller: pinController,
                maxLength: 4,
                defaultBorderColor: Colors.grey,
                pinBoxWidth: 60,
                pinBoxHeight: 60,
                pinBoxRadius: 12,
                pinBoxColor: Colors.white,
                pinBoxBorderWidth: 2,
                pinTextStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CodeTimer(remainingTime: _remainingTime),
              const SizedBox(height: 16),
              Obx(() {
                return Visibility(
                  visible: _enableResendCodeButton.value,
                  child: TextButton(
                    onPressed: () {
                      _startTimer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Verification code resent.")),
                      );
                    },
                    child: const Text(
                      "Resend Code",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
            CustomElevatedButton(text: "Next", hSize: 50, vSize: 20, onPressed: (){
             if(pinController.text=="1234"){
               verifyResetCode();
             // checkEmailVerification();
             }else{
               Get.snackbar("Error", "Invalid verification code");
             }
            }, colors: Colors.black87),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

