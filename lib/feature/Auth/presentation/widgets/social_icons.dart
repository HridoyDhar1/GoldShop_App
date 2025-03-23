import 'package:flutter/material.dart';
import 'package:goldshop/core/services/auth_service.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(radius: 20,child: Image.asset("assets/icons/facebook.png"),

        ),
        const SizedBox(width: 5,),
        GestureDetector(
          onTap: () async {
            AuthService authService = AuthService();
            await authService.signInWithGoogle();
          },
          child: CircleAvatar(radius: 20,
            backgroundColor: Colors.transparent,
            child: Image.asset("assets/icons/search.png"),

          ),
        ),const SizedBox(width: 5,),
        CircleAvatar(radius: 20,child: Image.asset("assets/icons/facebook.png"),

        ),
      ],
    );
  }
}
