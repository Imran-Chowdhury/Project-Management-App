




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/models/task_model/task_model.dart';
import 'package:project_management_app/view_models/task_view_model.dart';

class ProjectScreen extends ConsumerWidget {



   ProjectScreen({super.key, required this.projectName,required this.taskList});

  String projectName;
  List<Task>? taskList;

  




  @override

  Widget build(BuildContext context, WidgetRef ref) {

    var taskState = ref.watch(taskViewModelProvider(projectName));
    TaskViewModelNotifier taskController = ref.watch(taskViewModelProvider(projectName).notifier);
    //  DateTime now = DateTime.now();
    List<Task>? listOfTasks = taskList;


    if(taskState is TaskSuccessState){
      taskList = taskState.data;
    }

    // String formattedDate = DateFormat('dd MMM yyyy').format(now);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  return SafeArea(
    child: Scaffold(
      body: Stack( // Wrap the Column with a Stack
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    projectName,
                    style: const TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
            // (taskState is TaskSuccessState&&taskState.nameOfProject == projectName)?tasks(taskState.data): tasks(taskList),
            (taskState is TaskSuccessState)?tasks(taskState.data): tasks(taskList),
          //  tasks(taskList),

            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 20.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: add(context, formKey, taskController, taskList,projectName),
              ),
            ),
        ],
      ),
    ),
  );
}
  
Widget add(BuildContext context,GlobalKey<FormState> formKey, TaskViewModelNotifier  taskController,  List<Task>? taskList, String projectTitle){
    return  FloatingActionButton(
      backgroundColor: Colors.pinkAccent,
      shape: const CircleBorder(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController titleController = TextEditingController();
            // TextEditingController descriptionController = TextEditingController();

            return AlertDialog(
              title: const Text('Add ta new task'),
              contentPadding: const EdgeInsets.all(24), // Adjust padding for bigger size
              content: Form(
                key:  formKey,
                // mainAxisSize: MainAxisSize.min,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Task',
                      ), 
                      validator: (value) {

                        if (value!.isEmpty) {
                          return 'Please enter a task';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // TextFormField(
                    //   maxLength: 100,
                    //   controller: descriptionController,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Add Description',
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please add a description';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                // TextButton(
                //   onPressed: () {
                //     projectController.deleteFileFromSharedPreferences('project_file');
                //     Navigator.of(context).pop();
                //   },
                //   child: const Text('Delete the file'),
                // ),
                
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Validation passed, proceed with saving
                      // int id = 1;
                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('dd MMM yyyy').format(now);
                      // String title = titleController.text;
                      // String description = descriptionController.text;

                      String title = titleController.text;
                      // Perform save operation or any other logic here
                      taskController.addTaskToProject(taskList, projectTitle,  {
                        // 'taskTitle': title,
      
                        //  'date': formattedDate,

                         'Task Title': title,
      
                         'Date of Creation': formattedDate,
                      });
                    
                    


                      // print('Title: $title, Description: $description, Date: $formattedDate');
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
}


Widget tasks(List<Task>? taskList){
  // print(taskList!.length);
  return taskList!.isNotEmpty? Expanded(
         child: ListView.builder(
          itemCount: taskList.length, // Number of items
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                height: 50, // Adjust height as needed
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue,
              ),
                margin: const EdgeInsets.all(5), // Add margin for spacing
                alignment: Alignment.center,
                child: Text(
                  taskList[index].taskTitle,
                  // 'Item ${index + 1}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          },
               ),
       ):const Center(child: Text('No data'),);
}


}