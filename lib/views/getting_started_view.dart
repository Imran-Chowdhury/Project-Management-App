
import 'package:flutter/material.dart';
import 'package:project_management_app/utils/validator.dart';
import 'package:project_management_app/views/signin_view.dart';
import 'package:project_management_app/views/signup_view.dart';
import 'package:project_management_app/widgets/custom_button.dart';
import 'package:project_management_app/widgets/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    double width = size.width;
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

        ],
      ),
    );
  }
}
