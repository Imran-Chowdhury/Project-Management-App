
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    double height = size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFffca40), // If the image has transparency

      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Splash_screen.png', // Your image path
             height: height*.5, // Make sure the image covers the whole screen
            ),
          ),

          // const AuthChecker(),

        ],
      ),
    );
  }
}
