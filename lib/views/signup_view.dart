
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_management_app/utils/validator.dart';
import 'package:project_management_app/widgets/custom_button.dart';
import 'package:project_management_app/widgets/custom_textfield.dart';

import '../view_models/profile_view_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    final profileController = ref.read(profileViewModelProvider.notifier);
    final profileState = ref.watch(profileViewModelProvider);

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
                  'assets/images/signup.png', // Your image path
                  height: height * .5, // Adjust the height as needed
                ),
                SizedBox(height: height * .05),
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * .02),

                CustomTextField(controller: _nameController, labelText: 'Name', validate: Validator.personNameValidator),
                SizedBox(height: height * .04),

                CustomTextField(controller: _emailController, labelText: 'Email', validate: Validator.emailValidator),
                SizedBox(height: height * .04),

                CustomTextField(controller: _passwordController, labelText: 'Password', validate: Validator.passwordValidator),
                SizedBox(height: height * .04),

                CustomTextField(controller: _confirmPasswordController, labelText: 'Confirm Password', validate: Validator.confirmPasswordValidator),
                SizedBox(height: height * .04),

                Padding(
                  padding: EdgeInsets.only(left: width * 0.2, right: width * 0.2),
                  child: CustomButton(
                    screenHeight: height,
                    buttonName: 'SignUp',
                    buttonColor: const Color(0xFF00bfa6),
                    icon: const Icon(
                      Icons.app_registration_outlined,
                      color: Colors.white,
                    ),
                    onpressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
                          // Trigger sign-up logic here
                          await profileController.signUp(
                              _nameController.text.trim(),
                              _passwordController.text.trim(),
                              _passwordController.text.trim(),
                              _confirmPasswordController.text.trim(),
                              context
                          );
                        }
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

