import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_management_app/view_models/profile_view_model.dart';
import 'package:project_management_app/views/getting_started_view.dart';
import 'package:project_management_app/views/home_view.dart';
import 'package:project_management_app/views/project_view.dart';
import 'package:project_management_app/views/signin_view.dart';
// import 'package:project_management_app/view_models/profile_view_model_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'base_state/profile_state.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SafeArea(
        child:
        // SplashScreen(),
        AuthChecker(), // Check for authentication status on startup
      ),
    );
  }
}

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use FutureBuilder to check user profile in SharedPreferences
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 1),
            () => ref.read(profileViewModelProvider.notifier).currentUser(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  SplashScreen();
            // const Center(child: CircularProgressIndicator()); // Loading spinner
        } else if (snapshot.hasData && ref.watch(profileViewModelProvider) is ProfileSuccessState) {
          // If the user is found, navigate to ProjectScreen
          return HomeScreen();
        } else {
          // If no user is found, show the LoginScreen
          // return SplashScreen();
            return SignInScreen();
        }
      },
    );
  }
}
