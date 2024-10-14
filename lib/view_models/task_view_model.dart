



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

  Future<List<Task>> getTasks(String userId, String projectId, String token) async {
    List<Task> allTasks = [];
    // state = const LoadingState();
    final res = await restClient.getAllTasks(userId,projectId, token);
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

        listOfTasks.add(Task.fromjson(R));

      }



      state = SuccessState(data: listOfTasks);
    });


  }


  Future<void> updateTask(List<Task> listOfTasks,int index, Map<String,dynamic> data, String taskID)async{
    state = const LoadingState();
    final res = await restClient.updateTask(data,taskID);

    res.fold((L) {
      state = ErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      if(R.isNotEmpty){

        listOfTasks[index] = Task.fromjson(R);


      }



      state = SuccessState(data: listOfTasks);
      // Fluttertoast.showToast(msg: 'Task modified');
    });

  }

  Future<void> deleteTask(List<Task> listOfTasks,int index, String taskID)async{
    state = const LoadingState();
    final res = await restClient.deleteTask(taskID);


    res.fold((L) {
      state = ErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      if(R.isNotEmpty){

       listOfTasks.removeAt(index);

      }
      state = SuccessState(data: listOfTasks);
      Fluttertoast.showToast(msg: R);
    });

  }

  Future<void> toggleTaskCompletion(List<Task>listOfTask, int index, Task task) async {
    final updatedTask = task.copyWith(completed: !task.completed);
    // listOfTask[index] = updatedTask;
    // state = SuccessState(data: listOfTask);

    Map<String,dynamic> data =  {
      "task_name": updatedTask.taskTitle,
      "completed": updatedTask.completed,
    };
    String taskID = updatedTask.id.toString();

    await updateTask(listOfTask , index,  data, taskID);
  }




}









