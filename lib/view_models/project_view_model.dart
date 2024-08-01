



import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/models/project_model/project_model.dart';
import 'package:project_management_app/network/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


final projectViewModelProvider = StateNotifierProvider((ref) {
  return ProjectViewModelNotifier(restClient: ref.read(restClientProvider));
});



class ProjectViewModelNotifier extends StateNotifier<BaseState> {
  ProjectViewModelNotifier({required this.restClient})
      : super(const InitialState());

  RestClient restClient;

  Future<List<Project>> getProjects() async {
    List<Project> allProjects = [];
    // state = const LoadingState();
    final res = await restClient.getAllProjects();
    res.fold((L) {
      state = ErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      state = const LoadingState();
      if(R.isNotEmpty){
        for (int i = 0; i < R.length; i++) {
          allProjects.add(Project.fromjson(R[i]));
        }
      }

      state = SuccessState(data: allProjects);
    });
    return allProjects;
  }


  Future<void> addProject(List<Project> listOfProjects, Map<String,dynamic> data)async{
    state = const LoadingState();
    final res = await restClient.addProject(data);

    res.fold((L) {
      state = ErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      if(R.isNotEmpty){
        // for (int i = 0; i < R.length; i++) {
          listOfProjects.add(Project.fromjson(R));
        // }
      }
      // listOfProjects.add(Project.fromjson(R[i]));


      state = SuccessState(data: listOfProjects);
    });


  }

  Future<void> updateProject(List<Project> listOfProjects,int index, Map<String,dynamic> data, String projectID)async{
    state = const LoadingState();
    final res = await restClient.updateProject(data,projectID);

    res.fold((L) {
      state = ErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      if(R.isNotEmpty){
        // for (int i = 0; i < R.length; i++) {
        listOfProjects[index] = Project.fromjson(R);
        // listOfTasks.add(Task.fromjson(R));
        // }
      }
      // listOfProjects.add(Project.fromjson(R[i]));


      state = SuccessState(data: listOfProjects);
      Fluttertoast.showToast(msg: 'Project updated');
    });

  }

  Future<void> deleteProject(List<Project> listOfProjects,int index, String projectID)async{
    state = const LoadingState();
    final res = await restClient.deleteProject(projectID);


    res.fold((L) {
      state = ErrorState(L);
      Fluttertoast.showToast(msg: L);
    }, (R) {
      if(R.isNotEmpty){

        listOfProjects.removeAt(index);

      }
      state = SuccessState(data: listOfProjects);
      Fluttertoast.showToast(msg: R);
    });

  }

  


}