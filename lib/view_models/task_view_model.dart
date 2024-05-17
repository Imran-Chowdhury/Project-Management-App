



import 'dart:convert';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/models/task_model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


// StateNotifierProvider<TaskViewModelNotifier, Object?> taskViewModelProvider = StateNotifierProvider((ref) => TaskViewModelNotifier());
final taskViewModelProvider = StateNotifierProvider.family((ref, nameOfProject) => TaskViewModelNotifier());


class TaskViewModelNotifier extends StateNotifier<BaseState>{
  TaskViewModelNotifier():super(const TaskInitialState());




  Future<void> addTaskToProject(List<Task>? taskList,String projectTitle, Map<String, dynamic> taskmap) async {


   try{
     state  = const TaskLoadingState();


   SharedPreferences prefs = await SharedPreferences.getInstance();
   const String fileName = 'project_file';
  
  // Retrieve the contents of the JSON file from SharedPreferences
  // List<dynamic> fileContent = prefs.getStringList(fileName)?.map((e) => json.decode(e)).toList() ?? [];

  // List<dynamic> fileContent = prefs.getStringList(fileName)?.map((e) => json.decode(e) as Map<String, dynamic>).toList() ?? [];
  // print('The file content is ${fileContent}');


  final String? jsonString = prefs.getString(fileName);
      List<dynamic> fileContent = json.decode(jsonString!);

      for(var projectMap in fileContent){
        // // Find the project by its title
        if(projectMap['Project title'] == projectTitle){
          // // add the task to that project
          projectMap['Tasks'].add(taskmap);
           break;
        }
      }

  // // Find the project by its title
  // int index = fileContent.indexWhere((element) => element['Project title'] == projectTitle);

  


  // if (index != -1) {
  //   // Update the "Tasks" key by adding a new map of task
  //   fileContent[index]['Tasks'].add(taskmap);
    
    // Save the updated JSON content back to SharedPreferences
     
    // List<String> updatedContent = fileContent.map((e) => json.encode(e)).toList();
    // await prefs.setStringList(fileName, updatedContent);


    // Serialize the updated content back to JSON
String updatedJsonString = json.encode(fileContent);

// Save the updated JSON string back to shared preferences
await prefs.setString(fileName, updatedJsonString);




  taskList?.add(Task.fromjson(taskmap));


  state = TaskSuccessState(data: taskList, nameOfProject: projectTitle);

   }catch(e){
    state = const  ErrorState('An error occured while saving the task');
    rethrow;
   }




  
}







}


