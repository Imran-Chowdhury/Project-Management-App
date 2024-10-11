



import 'package:project_management_app/models/task_model/task_model.dart';





class Project {
  final int id;
  final String name;
  final String description;
  // final List<Task>? tasks;
  // final List<Map<String, dynamic>>? tasks;
  // final List<dynamic>? tasks;
  final String date;

  Project({required this.id, required this.name,  required this.description, required this.date });



 factory Project.fromjson(Map<String,dynamic> projectJson){

    return Project(

      id: projectJson['id'],
      name:  projectJson['project_name'],
      // tasks:  projectJson['Tasks'],
      description: projectJson['description'],
      date: projectJson['created_on'],


      );
  }

}

