



import 'package:project_management_app/models/task_model/task_model.dart';





class Project {
  final String id;
  final String name;
  final List<Task> tasks;

  Project({required this.id, required this.name, required this.tasks});



 factory Project.fromjson(Map<String,dynamic> projectJson){

    return Project(id: projectJson['id'], name:  projectJson['projectName'], tasks:  projectJson['taskList']);
  }


}