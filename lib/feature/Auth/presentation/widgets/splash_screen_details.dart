import 'package:flutter/material.dart';
import 'package:goldshop/core/constant/app_string.dart';
import 'package:goldshop/core/utils/responsive.dart';

class SplashScreenDetails extends StatelessWidget {
  const SplashScreenDetails({
    super.key,
    required this.responsive,
  });

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(Texts.splashScreenTtile,style: TextStyle(fontSize: responsive.getSubtitleFontSize(),color: Colors.black,fontWeight: FontWeight.bold),
        ),

        Text(Texts.splashScreenSubTitle,style: TextStyle(fontSize: responsive.getTitleFontSize(),color: Colors.black87,fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        Text(Texts.splashScreenDes,style:TextStyle(fontSize: responsive.getTextDes()),textAlign: TextAlign.center,),
      ],
    );
  }
}

