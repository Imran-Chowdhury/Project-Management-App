




import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

final restClientProvider = Provider((ref) => RestClient());



class RestClient {


  // Future<Either<String,Response>> getAllProjects( Map<String, dynamic> data, Map<String,String> headers) async {
  Future<Either<String, List<dynamic>>> getAllProjects() async {
  // Future<void> getAllProjects() async {

    // String signUpUrl = API.signUpUrl;
    String getProjectUrl = 'http://192.168.0.106:8000/get_project/';


    // final response = await http.post(
    //   Uri.parse(getProjectUrl),
    //   headers: headers,
    //   body: jsonEncode(data),
    // ).then((value) => value);

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

  final response = await http.post(
    Uri.parse('http://192.168.0.106:8000/add_project/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // body: jsonEncode(<String, dynamic>{
    //   'task_name': taskName,
    //   'completed': completed ? 1 : 0,
    // }),
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

