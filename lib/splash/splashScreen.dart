
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskapp/Screens/LoginScreen.dart';
import 'package:taskapp/Screens/homePage.dart';
import 'package:taskapp/Screens/registerScreen.dart';
import 'package:taskapp/ViewModel/data/local/Shared_Prefreance.dart';
import 'package:taskapp/ViewModel/data/local/shredKeys.dart';
import 'package:taskapp/utils/AppImages.dart';
class slashScreen extends StatelessWidget {
  const slashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // delaying the opening Screen
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/Lottie/Animation - 1700204818365.json" , fit: BoxFit.cover),
      nextScreen:( LocalData.getData(key: SharedKey.token ) != null) ?  const  homePage() : const LoginScreen(),
     animationDuration:const Duration(seconds: 2),
     // pageTransitionType: PageTransitionType.scale,
    );
  }
}
