
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:project_management_app/views/home_view.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    const ProviderScope(child:  MyApp()),
    
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(child: HomeScreen(),),
    );
  }
}




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
