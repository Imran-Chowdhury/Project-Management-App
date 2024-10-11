

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_management_app/base_state/profile_state.dart';
import 'package:project_management_app/models/profile_model/profile_model.dart';
import 'package:project_management_app/network/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/home_view.dart';
import '../views/signin_view.dart';


final profileViewModelProvider = StateNotifierProvider((ref) {
  return ProfileViewModelNotifier(restClient: ref.read(restClientProvider));
});

class ProfileViewModelNotifier extends StateNotifier<ProfileState>{
  ProfileViewModelNotifier({required this.restClient}) : super(const ProfileInitialState());

  RestClient restClient;

  Future<void> logIn(String userName, String passWord, BuildContext context) async {
    // Data to be sent to the API
    Map<String, dynamic> data = {
      "username": userName,
      "password": passWord,
    };

    // Declare profile as nullable to allow for initialization after the API call
    Profile? profile;

    // Call the API
    final res = await restClient.signIn(data);

    print('logging in.... ');

    // Handle the response
    res.fold((L) {
      // On error, update the state with the error message
      state = ProfileErrorState(L['error']);
      Fluttertoast.showToast(msg: L['error']);
    }, (R) async {
      // Start with loading state
      state = const ProfileLoadingState();

      if (R.isNotEmpty) {
        // Parse the JSON response into the Profile model
        profile = Profile.fromjson(R);

        // Save profile to shared preferences (you can handle this later)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('profile', jsonEncode(R));

        Fluttertoast.showToast(msg: 'Welcome');
        state = ProfileSuccessState(data: profile!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );


      }else{
        state = const ProfileErrorState('An error occurred');
        Fluttertoast.showToast(msg: 'An error occurred');
      }
    });
  }


  Future<void> signUp(String userName, String passWord,String confirmPassword,String email, BuildContext context) async {
    // Data to be sent to the API
    Map<String, dynamic> data = {
      "username": userName,
      "password": passWord,
      "confirm_password": confirmPassword,
      "email": email
    };

    // Declare profile as nullable to allow for initialization after the API call
    Profile? profile;

    // Call the API
    final res = await restClient.signUp(data);

    print('Signing up.... ');

    // Handle the response
    res.fold((L) {
      // On error, update the state with the error message
      state = ProfileErrorState(L['error']);
      Fluttertoast.showToast(msg: L['error']);
    }, (R) async {
      // Start with loading state
      state = const ProfileLoadingState();

      if (R.isNotEmpty) {
        // Parse the JSON response into the Profile model
        profile = Profile.fromjson(R);

        // Save profile to shared preferences (you can handle this later)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('profile', jsonEncode(R));

        Fluttertoast.showToast(msg: 'User registered successfully');
        state = ProfileSuccessState(data: profile!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );


      }else{
        state = const ProfileErrorState('An error occurred');
        Fluttertoast.showToast(msg: 'An error occurred');
      }
    });
  }


  // Future<Map<String, dynamic>> currentUser()async{
  Future<Map<String, dynamic>> currentUser()async{


    state = const ProfileLoadingState();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Try to get the stored profile data
    String? profileJson = prefs.getString('profile');

    if (profileJson != null) {
      // Convert the JSON string back to a Map<String, dynamic>
      // return jsonDecode(profileJson) as Map<String, dynamic>;
      Map<String,dynamic> user = jsonDecode(profileJson) as Map<String, dynamic>;
      Profile profile = Profile.fromjson(user);
      state = ProfileSuccessState(data: profile);
    }
    // state  = const ProfileErrorState('');

    // If not found, return an empty map
    return {};
  }

  Future<void> logout(String refreshToken, BuildContext context) async {
    // Prepare the data to send for sign out
    Map<String, dynamic> data = {
      "refresh_token": refreshToken,
    };

    // Call the signOut function from your restClient
    final res = await restClient.signOut(data);

    // Handle the response from the server
    res.fold(
          (L) {
        // On error, update the state with the error message
        state = ProfileErrorState(L['error']);
        Fluttertoast.showToast(msg: L['error']);
      },
          (R) async {
        // Start with loading state while processing the logout
        state = const ProfileLoadingState();

        // Clear shared preferences after logout
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Reset the state to the initial profile state
        state = const  ProfileInitialState();
        // await Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => SignInScreen()),
        //       (route) => false, // This ensures the back button will exit the app
        // );

        // Optionally, show a success message
        Fluttertoast.showToast(msg: 'Logged out successfully');
      },
    );
  }


}
