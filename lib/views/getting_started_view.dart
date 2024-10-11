
import 'package:flutter/material.dart';
import 'package:project_management_app/utils/validator.dart';
import 'package:project_management_app/views/signin_view.dart';
import 'package:project_management_app/views/signup_view.dart';
import 'package:project_management_app/widgets/custom_button.dart';
import 'package:project_management_app/widgets/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';


class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery. of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFffffff) ,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/getting_started.png', // Your image path
                  height: height*.61, // Adjust the height as needed
                ),
                // SvgPicture.asset(
                //   'assets/images/getting_started.svg',
                //   height:height*.5,
                //   // width: 100,
                //   // Change the color of the SVG
                // ),
                SizedBox(height: height*.01),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Text(
                  'Getting Started',
                  style: TextStyle(
                      // fontSize: 25,
                      fontWeight: FontWeight.bold,
                    color: Colors.black45
                  ),
                ),
                SizedBox(height: height*.02),
                // SizedBox(height: height*.04),




                Padding(
                  padding:  EdgeInsets.only(left: width *0.2,right: width*0.2),
                  child: CustomButton(
                    screenHeight: height,
                    buttonName: 'SignUp',
                    buttonColor: const Color(0xFF00bfa6),
                    icon: const Icon(
                      Icons.app_registration_outlined,
                      color: Colors.white,),

                    onpressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      // if (_formKey.currentState!.validate()) {
                      //   // If the form is valid, display a message
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Signing Up...')),
                      //   );
                      // }
                    },

                  ),
                ),
                SizedBox(height: height*.04),

                Padding(
                  padding:  EdgeInsets.only(left: width *0.2,right: width*0.2),
                  child: CustomButton(
                    screenHeight: height,
                    buttonName: 'SignIn',
                    buttonColor: const Color(0xFF00bfa6),
                    icon: const Icon(
                      Icons.login_outlined,
                      color: Colors.white,),

                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a message
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Signing Up...')),
                        // );
                      }
                    },

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}