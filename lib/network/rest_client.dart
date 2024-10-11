




import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

final restClientProvider = Provider((ref) => RestClient());



class RestClient {
/////////////////////////////////////User///////////////////////////////
  Future<Either<Map<String,dynamic>, Map<String,dynamic>>> signIn(Map<String,dynamic> data) async {

    String getSignInUrl = '${API.baseUrl}login/';
    Response response = await http.post(
        Uri.parse(getSignInUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
     Map<String,dynamic> successBody = json.decode(response.body);

      return Right(successBody);
    } else {
      Map<String,dynamic> errorBody = json.decode(response.body);
      return  Left(errorBody);

    }

  }

  Future<Either<Map<String,dynamic>,String>> signOut(Map<String,dynamic> data) async {

    String signOutUrl = '${API.baseUrl}logout/';
    Response response = await http.post(
      Uri.parse(signOutUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      String successBody = json.decode(response.body);

      return Right(successBody);
    } else {
      Map<String,dynamic> errorBody = json.decode(response.body);
      return  Left(errorBody);

    }

  }

/////////////////////////////////////Project request//////////////////////////////////
  Future<Either<String, List<dynamic>>> getAllProjects() async {

    String getProjectUrl = '${API.baseUrl}get_project/';
    Response response = await http.get(Uri.parse(getProjectUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      print(body);
      return Right(body);
    } else {
      return const Left('Failed to load projects');

    }

  }

  Future<Either<String, Map<String, dynamic>>> addProject( Map<String, dynamic> data,) async {

    String addProjectUrl = '${API.baseUrl}add_project/';


  final response = await http.post(
    Uri.parse(addProjectUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },

    body: jsonEncode(data),
  );

  if (response.statusCode == 201) {
    Map<String, dynamic> body = json.decode(response.body);
    return Right(body);
  } else {
    return const  Left('Failed to add a project');
  }
}


  Future<Either<String, Map<String, dynamic>>> updateProject( Map<String, dynamic> data,String projectId) async {
    String updateTaskUrl =  '${API.baseUrl}update_project/$projectId';
    final response = await http.put(
        Uri.parse(updateTaskUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return Right(body);
    }else {
      return const  Left('Failed to add a project');
    }
  }

  Future<Either<String,String>> deleteProject(String projectId) async {
    final String apiUrl = '${API.baseUrl}delete_project/$projectId';

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      return const Right('Project deleted successfully');
      // print('Task deleted successfully');
    } else {
      return const Left('Failed to delete project');
      // print('Failed to delete task: ${response.statusCode}');
    }
  }


/////////////////////////////////////Task requests/////////////////////////////////////////////
  Future<Either<String, List<dynamic>>> getAllTasks(String projectId) async {

    String getTaskUrl = '${API.baseUrl}get_task/$projectId';
    Response response = await http.get(Uri.parse(getTaskUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      print(body);
      return Right(body);
    } else {
      return const Left('Failed to load projects');

    }

  }

  Future<Either<String, Map<String, dynamic>>> addTask( Map<String, dynamic> data,String projectId) async {
    String addTaskUrl = '${API.baseUrl}add_task/$projectId';
    final response = await http.post(
      Uri.parse(addTaskUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> body = json.decode(response.body);
      return Right(body);
    } else {
      return const  Left('Failed to add a project');
    }
  }


  Future<Either<String, Map<String, dynamic>>> updateTask( Map<String, dynamic> data,String taskId) async {
    String updateTaskUrl =  '${API.baseUrl}update_task/$taskId';
    final response = await http.put(
      Uri.parse(updateTaskUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return Right(body);
    }else {
      return const  Left('Failed to add a project');
    }
  }

  Future<Either<String,String>> deleteTask(String taskId) async {
    final String apiUrl = '${API.baseUrl}delete_task/$taskId';

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      return const Right('Task deleted successfully');
      // print('Task deleted successfully');
    } else {
      return const Left('Failed to delete task');
      // print('Failed to delete task: ${response.statusCode}');
    }
  }



}

