




import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

final restClientProvider = Provider((ref) => RestClient());



class RestClient {



  Future<Either<String, List<dynamic>>> getAllProjects() async {

    String getProjectUrl = 'http://192.168.0.106:8000/get_project/';
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

    String addProjectUrl = 'http://192.168.0.106:8000/add_project/';

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

  Future<Either<String, List<dynamic>>> getAllTasks(String projectId) async {

    String getTaskUrl = 'http://192.168.0.106:8000/get_task/$projectId';
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
    String addTaskUrl = 'http://192.168.0.106:8000/add_task/$projectId';
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







}

