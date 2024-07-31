



import 'dart:convert';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/models/task_model/task_model.dart';
import 'package:project_management_app/network/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


// StateNotifierProvider<TaskViewModelNotifier, Object?> taskViewModelProvider = StateNotifierProvider((ref) => TaskViewModelNotifier());
final taskViewModelProvider = StateNotifierProvider.family((ref, projectID) => TaskViewModelNotifier(restClient: ref.read(restClientProvider)));


class TaskViewModelNotifier extends StateNotifier<BaseState>{
  TaskViewModelNotifier({required this.restClient}):super(const TaskInitialState());

  RestClient restClient;

  Future<List<Task>> getTasks(String projectId) async {
    List<Task> allTasks = [];
    // state = const LoadingState();
    final res = await restClient.getAllTasks(projectId);
    res.fold((L) {
      state = TaskErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      if(R.isNotEmpty){
        for (int i = 0; i < R.length; i++) {
          allTasks.add(Task.fromjson(R[i]));
        }
      }

      state = TaskSuccessState(data: allTasks);
    });
    return allTasks;
  }

  Future<void> addTask(List<Task> listOfTasks, Map<String,dynamic> data, String prjectID)async{
    state = const LoadingState();
    final res = await restClient.addTask(data,prjectID);

    res.fold((L) {
      state = ErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      if(R.isNotEmpty){
        // for (int i = 0; i < R.length; i++) {
        listOfTasks.add(Task.fromjson(R));
        // }
      }
      // listOfProjects.add(Project.fromjson(R[i]));


      state = SuccessState(data: listOfTasks);
    });


  }







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


