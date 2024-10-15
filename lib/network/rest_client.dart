




import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

final restClientProvider = Provider((ref) => RestClient());



class RestClient {
/////////////////////////////////////User///////////////////////////////

  Future<Either<Map<String,dynamic>, Map<String,dynamic>>> signUp(Map<String,dynamic> data) async {

    String getSignUpUrl = '${API.baseUrl}register/';
    Response response = await http.post(
      Uri.parse(getSignUpUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      Map<String,dynamic> successBody = json.decode(response.body);

      return Right(successBody);
    } else {
      Map<String,dynamic> errorBody = json.decode(response.body);
      return  Left(errorBody);

    }

  }




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

    if (response.statusCode == 205) {
      String successBody = json.decode(response.body);

      return Right(successBody);
    } else {
      Map<String,dynamic> errorBody = json.decode(response.body);
      return  Left(errorBody);

    }

  }

/////////////////////////////////////Project request//////////////////////////////////
//   Future<Either<String, List<dynamic>>> getAllProjects() async {
//
//     String getProjectUrl = '${API.baseUrl}get_project/';
//     Response response = await http.get(Uri.parse(getProjectUrl));
//
//     if (response.statusCode == 200) {
//       List<dynamic> body = json.decode(response.body);
//       print(body);
//       return Right(body);
//     } else {
//       return const Left('Failed to load projects');
//
//     }
//
//   }
//
//   Future<Either<String, Map<String, dynamic>>> addProject( Map<String, dynamic> data,) async {
//
//     String addProjectUrl = '${API.baseUrl}add_project/';
//
//
//   final response = await http.post(
//     Uri.parse(addProjectUrl),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//
//     body: jsonEncode(data),
//   );
//
//   if (response.statusCode == 201) {
//     Map<String, dynamic> body = json.decode(response.body);
//     return Right(body);
//   } else {
//     return const  Left('Failed to add a project');
//   }
// }
//
//
//   Future<Either<String, Map<String, dynamic>>> updateProject( Map<String, dynamic> data,String projectId) async {
//     String updateTaskUrl =  '${API.baseUrl}update_project/$projectId';
//     final response = await http.put(
//         Uri.parse(updateTaskUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data));
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> body = json.decode(response.body);
//       return Right(body);
//     }else {
//       return const  Left('Failed to add a project');
//     }
//   }
//
//   Future<Either<String,String>> deleteProject(String projectId) async {
//     final String apiUrl = '${API.baseUrl}delete_project/$projectId';
//
//     final response = await http.delete(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 204) {
//       return const Right('Project deleted successfully');
//       // print('Task deleted successfully');
//     } else {
//       return const Left('Failed to delete project');
//       // print('Failed to delete task: ${response.statusCode}');
//     }
//   }

  // Get all projects
  Future<Either<String, List<dynamic>>> getAllProjects(String token) async {
    String getProjectUrl = '${API.baseUrl}get_project/';

    final response = await http.get(
      Uri.parse(getProjectUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      print(body);
      return Right(body);
    } else {
      return const Left('Failed to load projects');
    }
  }

// Add a project
  Future<Either<String, Map<String, dynamic>>> addProject(Map<String, dynamic> data, String token) async {
    String addProjectUrl = '${API.baseUrl}add_project/';

    final response = await http.post(
      Uri.parse(addProjectUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> body = json.decode(response.body);
      return Right(body);
    } else {
      return const Left('Failed to add a project');
    }
  }

// Update a project
  Future<Either<String, Map<String, dynamic>>> updateProject(Map<String, dynamic> data, String projectId, String token) async {
    String updateProjectUrl = '${API.baseUrl}update_project/$projectId';

    final response = await http.put(
      Uri.parse(updateProjectUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return Right(body);
    } else {
      return const Left('Failed to update project');
    }
  }

// Delete a project
  Future<Either<String, String>> deleteProject(String projectId, String token) async {
    String apiUrl = '${API.baseUrl}delete_project/$projectId';

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 204) {
      return const Right('Project deleted successfully');
    } else {
      return const Left('Failed to delete project');
    }
  }



/////////////////////////////////////Task requests/////////////////////////////////////////////
//   Future<Either<String, List<dynamic>>> getAllTasks(String userId,String projectId) async {
//
//     String getTaskUrl = '${API.baseUrl}get_task/$projectId';
//     Response response = await http.get(Uri.parse(getTaskUrl));
//
//     if (response.statusCode == 200) {
//       List<dynamic> body = json.decode(response.body);
//       print(body);
//       return Right(body);
//     } else {
//       return const Left('Failed to load projects');
//
//     }
//
//   }


  Future<Either<String, List<dynamic>>> getAllTasks(String projectId, String token) async {
    // Build the URL
    String getTaskUrl = '${API.baseUrl}get_task/$projectId';

    // Set headers including the token for Authorization
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the Authorization header
    };

    // Make the GET request
    Response response = await http.get(
      Uri.parse(getTaskUrl),
      headers: headers, // Pass the headers containing the token
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Decode the response body and return the task list
      List<dynamic> body = json.decode(response.body);
      print(body);
      return Right(body);
    } else {
      // Return an error message if the request failed
      return const Left('Failed to load tasks');
    }
  }





  Future<Either<String, Map<String, dynamic>>>
  addTask( Map<String, dynamic> data,String projectId, String token) async {
    // String addTaskUrl = '${API.baseUrl}add_task/$projectId';
    String addTaskUrl = '${API.baseUrl}projects/$projectId/tasks/add/';


    final response = await http.post(
      Uri.parse(addTaskUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
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


  Future<Either<String, Map<String, dynamic>>> updateTask( Map<String, dynamic> data,String taskId, String projectId) async {
    // String updateTaskUrl =  '${API.baseUrl}update_task/$taskId';
    String updateTaskUrl = '${API.baseUrl}projects/$projectId/tasks/$taskId/update/';
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

  Future<Either<String,String>> deleteTask(String projectId,String taskId) async {
    // final String apiUrl = '${API.baseUrl}delete_task/$taskId';
    final String apiUrl = '${API.baseUrl}projects/$projectId/tasks/$taskId/delete/';


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

