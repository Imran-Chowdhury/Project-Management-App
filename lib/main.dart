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

// Profile ViewModel Notifier provider
// final profileViewModelNotifierProvider = StateNotifierProvider<ProfileViewModelNotifier, ProfileState>(
//       (ref) => ProfileViewModelNotifier(restClient: RestClient()),
// );

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
      home: SafeArea(
        child: AuthChecker(), // Check for authentication status on startup
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
          return const Center(child: CircularProgressIndicator()); // Loading spinner
        } else if (snapshot.hasData && ref.watch(profileViewModelProvider) is ProfileSuccessState) {
          // If the user is found, navigate to ProjectScreen
          return HomeScreen();
        } else {
          // If no user is found, show the LoginScreen
          return SignInScreen();
        }
      },
    );
  }
}





//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:project_management_app/views/getting_started_view.dart';
//
//
// import 'package:project_management_app/views/home_view.dart';
// import 'package:project_management_app/views/signin_view.dart';
// import 'package:project_management_app/views/signup_view.dart';
//
//
//
//
// Future main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(
//     const ProviderScope(child:  MyApp()),
//
//     );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: SafeArea(child: HomeScreen(),),
//       // home: SafeArea(child: SignUpScreen(),),
//       // home: SafeArea(child: SignInScreen(),),
//       home: SafeArea(child: GettingStartedScreen(),),
//
//     );
//   }
// }
//



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Define a task model
// class Task {
//   final String name;

//   Task(this.name);
// }

// // Define a state class for tasks
// class TaskState {
//   final List<Task> tasks;

//   TaskState(this.tasks);
// }

// // Define a state notifier for managing tasks
// class TaskNotifier extends StateNotifier<TaskState> {
//   TaskNotifier(List<Task> tasks) : super(TaskState(tasks));

//   void addTask(Task task) {
//     state = TaskState([...state.tasks, task]);
//   }
// }

// // Define providers
// final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
//   return TaskNotifier([]);
// });

// void main() {
//   runApp(
//     ProviderScope(
//       child: MaterialApp(
//         home: FirstScreen(),
//       ),
//     ),
//   );
// }

// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('First Screen'),
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text('Eat'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SecondScreen(tasks: [Task('Eat')]),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('Sleep'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SecondScreen(tasks: [Task('Sleep')]),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SecondScreen extends ConsumerWidget {
//   final List<Task> tasks;

//   SecondScreen({required this.tasks});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final taskState = ref.watch(taskProvider);
//     final taskController  = ref.watch(taskProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Screen'),
//       ),
//       body: ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(tasks[index].name),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           final newTask = Task('Walk');
//           ref.watch(taskProvider.notifier).addTask(newTask);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }



// }
