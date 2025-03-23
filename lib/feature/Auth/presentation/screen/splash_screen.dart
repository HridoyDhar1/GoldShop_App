import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goldshop/core/constant/app_images.dart';
import 'package:goldshop/core/utils/responsive.dart';
import 'package:goldshop/feature/Auth/presentation/screen/singup_screen.dart';
import 'package:goldshop/feature/Auth/presentation/widgets/splash_screen_details.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.isDesktop ? 100 : 20, // More padding on desktops
              vertical: 20,
            ),
            child: responsive.isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset(
                          Images.splashScreenImage,
                          height: 400,
                          width: 400,
                        ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(
                        flex: 1,
                        child: _buildTextSection(responsive),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      SizedBox(
                        height: responsive.getImageSize(),
                        width: responsive.getImageSize(),
                        child: SvgPicture.asset(Images.splashScreenImage),
                      ),
                      const SizedBox(height: 20),
                      SplashScreenDetails(responsive: responsive),
                      const SizedBox(height: 100),
                      _buildButtonSection(responsive),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextSection(Responsive responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SplashScreenDetails(responsive: responsive),
        const SizedBox(height: 50),
        _buildButtonSection(responsive),
      ],
    );
  }

  Widget _buildButtonSection(Responsive responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, // Keep buttons aligned properly
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(
                horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Color(0xff1B353C)),
            onPressed: onTapSignIn,
            child: Text(
              "Sing in", style: TextStyle(color: Colors.white),)),
        const SizedBox(width: 20),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: onTapSingUp,
          child: const Text("Sign Up"),
        ),
      ],
    );
  }

  void onTapSignIn() {
 Get.toNamed(LoginScreen.name);
  }
  void onTapSingUp(){
    Get.toNamed(SignupScreen.name);
  }
}
