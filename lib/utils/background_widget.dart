import 'package:flutter/material.dart';



class BackgroundContainer extends StatelessWidget {
   BackgroundContainer({
    super.key,
  });
  Color backgroundColor = const Color(0xFF00bfa6);
  //  Color backgroundColor = const Color(0xFF213A57);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery. of(context).size;
    double width = size.width;
    double height = size.height;


    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/images/img.png', // Your image path
            height: height * .4, // Adjust the height as needed
          ),
        ),
        // Text(
        //   'Pro'
        // ),
      ],
    );
      // Container(
      // decoration:  BoxDecoration(
      //   color: backgroundColor,
      //   // gradient: LinearGradient(colors: [
      //   //  backgroundColor,
      //   //  const  Color.fromARGB(92, 95, 167, 231),
      //   // ],
      //   ),
      // );
    // );
  }
}