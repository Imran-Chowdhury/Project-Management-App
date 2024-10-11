
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/base_state/profile_state.dart';
import 'package:project_management_app/utils/validator.dart';
import 'package:project_management_app/view_models/profile_view_model.dart';
import 'package:project_management_app/views/signup_view.dart';
import 'package:project_management_app/widgets/custom_button.dart';
import 'package:project_management_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_view.dart';
// import 'your_project_path/profile_view_model_notifier.dart'; // Update this with your actual file path

class SignInScreen extends ConsumerStatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    // Access ProfileViewModelNotifier through Riverpod using ref
    final profileController = ref.read(profileViewModelProvider.notifier);
    final profileState = ref.read(profileViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0XFFffffff),
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
                  'assets/images/signin.png', // Your image path
                  height: height * 0.5, // Adjust the height as needed
                ),
                SizedBox(height: height * 0.0001),
                const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: _nameController,
                  labelText: 'Username',
                  validate: Validator.personNameValidator,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  validate: Validator.passwordValidator,
                ),
                // SizedBox(height: width * 0.1),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.2, right: width * 0.2),
                  child: CustomButton(
                    screenHeight: height,
                    buttonName: 'Sign In',
                    buttonColor: const Color(0xFF00bfa6),
                    icon: const Icon(
                      Icons.login_outlined,
                      color: Colors.white,
                    ),
                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform the sign-in logic
                        profileController.logIn(
                          _nameController.text.trim(),
                          _passwordController.text.trim(),
                          context
                        );
                      }
                    },


                  ),
                ),
                const SizedBox(height: 10),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const  Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                   const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                      },
                      child: const Text(
                          "Sign up!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
