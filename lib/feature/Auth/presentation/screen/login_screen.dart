
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Add this import
import 'package:goldshop/core/utils/responsive.dart';
import 'package:goldshop/core/widgets/custom_password_field.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/Auth/presentation/controllers/auth_controller.dart';
import 'package:goldshop/feature/Auth/presentation/screen/forget_password_screen.dart';
import 'package:goldshop/feature/Auth/presentation/screen/singup_screen.dart';
import 'package:goldshop/feature/Auth/presentation/widgets/social_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool showNewPasswordField = false; // Toggle for new password field
  bool isConnected = true; // To store connectivity status

  @override
  void initState() {
    super.initState();
    _checkInternetConnection(); // Check internet connection when the screen loads
  }

  // Check internet connection
  _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Hey,",
                  style: TextStyle(
                    fontSize: responsive.getTitleFontSize(),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: responsive.getTitleFontSize(),
                    color: Colors.black87,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 20),

                // Display message if no internet connection
                if (!isConnected)
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.redAccent,
                    child: const Text(
                      'No internet connection. Please connect to the internet.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                const SizedBox(height: 20),

                CustomTextField(
                  text: "text",
                  valid: "valid",
                  controller: emailOrPhoneController,
                  icons: Icons.email,
                  keyboard: TextInputType.text,
                  hintText: "Email",
                ),
                const SizedBox(height: 20),
                CustomPasswordField(
                  hintText: 'Password',
                  valid: "valid",
                  controller: passwordController,
                  icons: Icons.lock,
                  surfixIcons: Icons.visibility,
                  keyboard: TextInputType.text,
                ),
                const SizedBox(height: 20),

                // Show new password field only after reset
                if (showNewPasswordField)
                  CustomPasswordField(
                    hintText: 'New Password',
                    valid: "Enter new password",
                    controller: newPasswordController,
                    icons: Icons.lock_outline,
                    keyboard: TextInputType.text,
                  ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(ForgetPasswordScreen.name);
                    },
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xff1B353C),
                    ),
                    onPressed: () {
                      if (isConnected) {
                        if (emailOrPhoneController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          authController.loginUser(
                            email: emailOrPhoneController.text,
                            password: passwordController.text,
                          );
                        } else {
                          Get.snackbar(
                            "Error",
                            "Please enter your email and password",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      } else {
                        Get.snackbar(
                          "Error",
                          "No internet connection. Please connect to the internet.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Text(
                      "Singin",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(
                          text: " Sign Up",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(SignupScreen.name);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),

                /// Social Icons
                const SocialIcons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
