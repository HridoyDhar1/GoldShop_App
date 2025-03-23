import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldshop/core/utils/responsive.dart';
import 'package:goldshop/core/widgets/custom_password_field.dart';
import 'package:goldshop/core/widgets/custom_text_field.dart';
import 'package:goldshop/feature/Auth/presentation/widgets/social_icons.dart';
import 'package:goldshop/feature/ProfileDetails/presentation/screen/create_profile.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String name = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;



  Future<void> signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("User Created: ${userCredential.user?.uid}");

      await _firestore.collection("SignUp").doc(userCredential.user!.uid).set({
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "uid": userCredential.user!.uid,
      });

      print("User data saved to Firestore");

      Get.to(() => CreateProfileScreen());

    } catch (e) {
      print("Signup Error: $e");
    }

    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text("Create Account", style: TextStyle(fontSize: 30)),
                const SizedBox(height: 50),
                CustomTextField(text: "Full Name",
                    valid: "Enter full name",
hintText: "Full Name",
                    controller: fullNameController,
                    icons: Icons.person,
                    keyboard: TextInputType.emailAddress),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Email",
                  text: "Email",
                  // FIXED
                  valid: "Enter your email",
                  controller: emailController,
                  icons: Icons.email,
                  // FIXED ICON
                  keyboard: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                CustomPasswordField(
                  hintText: "Password",
                  valid: "Enter 8 digit password",
                  controller: passwordController,
                  icons: Icons.lock,
                  surfixIcons: Icons.visibility,
                  keyboard: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomPasswordField(
                  hintText: "Confirm Password",
                  valid: "Enter correct password",
                  controller: confirmPasswordController,
                  icons: Icons.lock,
                  surfixIcons: Icons.visibility,
                  keyboard: TextInputType.text,
                ),
                const SizedBox(height: 50),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff1B353C),
                  ),
                  onPressed: onTapNextButton,
                  child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                Divider(),
                const SizedBox(height: 20),
                SocialIcons(),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: " Sign in",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(LoginScreen.name);
                          },
                      ),
                    ],
                    text: "Already have an account!",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapNextButton() {
    if (_formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match!")),
        );
        return;
      }
      signUpUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields correctly")),
      );
    }
  }

}
