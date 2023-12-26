import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waste_management_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String splashScreenImageURL = "assets/app_images/splashScreen_image.png";
  String splashScreenNameURL = "assets/app_images/splashScreen_name.png";


  void initState(){
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.center,
        duration: Duration(milliseconds: 800),
        isIos: true,
        child: App(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150.0,
            child: Image.asset(
              splashScreenImageURL, // Replace "image.jpg" with the actual filename and extension of your image
              fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
            ),
          ),
          SizedBox(width: 500.0,),
          Container(
            width: 500.0,
            child: Image.asset(
              splashScreenNameURL, // Replace "image.jpg" with the actual filename and extension of your image
              fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
            ),
          ),
        ],
      )
    );
  }
}
