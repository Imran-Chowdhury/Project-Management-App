



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





 Future<List<Project>> saveOrUpdateJsonInSharedPreferences(int id, String title,String date , String description) async{
    state = const LoadingState();

   Future.delayed(const Duration(seconds: 5), () {
  print('Five second has passed.'); // Prints after 1 second.
});


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // const String title = 'My Project';
    // final String date = DateTime.now().toString();
    const String fileName = 'project_file';
    List<Project> allProjects = [];

    try{

   // Check if the file exists
    if (prefs.containsKey(fileName)) { 
      final String? jsonString = prefs.getString(fileName);
      List<dynamic> fileContent = json.decode(jsonString!);

      // Check if project title already exists
      bool projectExists = fileContent.any((project) => project['Project title'] == title);
      if (projectExists) {
        state = const ErrorState('The project already exists');

        print('The project already exists');
      } else {
        // Add new project to existing content
        
        fileContent.add({
          'Project title': title,
          'Description': description,
          'Date of Creation': date,
          // 'Tasks': [],
          'Tasks': [{
            'Task Title' : 'Test task',
            'Date of Creation': 'put one date here',
          },

          //  {
          //   'Task Title' : 'Test task2',
          //   'Date of Creation': 'put one date hereeeee',
          // },

          ],

          'Id':id,
        });
        // Save updated content back
        prefs.setString(fileName, json.encode(fileContent));
        state = const SuccessState();
        print('Project added successfully');
       allProjects =  await readMapFromSharedPreferences('project_file');
      }
    } else {
      // Create new file and add the first project
      List<dynamic> fileContent = [
        {
          'Project title': title,
          'Description': description,
          'Date of Creation': date,
          // 'Tasks': [],
              'Tasks': [{
            'Task Title' : 'Test task',
            'Date of Creation': 'put one date here',
          },
          // {
          //   'Task Title' : 'Test task2',
          //   'Date of Creation': 'put one date hereeeee',
          // },
          ],
          'Id':id,
        }
      ];
      // Save content
      prefs.setString(fileName, json.encode(fileContent));
      state = const SuccessState();
      print('Project file created successfully');

        allProjects =   await readMapFromSharedPreferences('project_file');

    }


   }catch(error){
        state = const ErrorState('An error occured while saving the project');
        print(error.toString());
        // rethrow;
        
      
    }

 

    return allProjects;
  } 




  Future<List<Project>> readMapFromSharedPreferences(String nameOfJsonFile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final  String fileName = nameOfJsonFile;
    List<Project> allProjects = [];

    try{
      state = const LoadingState();
        // Check if the file exists
        if (prefs.containsKey(fileName)) {
          final String? jsonString = prefs.getString(fileName);
          List<dynamic> fileContent = json.decode(jsonString!);
          // print(fileContent);

          // Print all project data
          for (var projectMap in fileContent) {
            


          allProjects.add(Project.fromjson(projectMap)); 


            print('ID: ${projectMap['Id']}'); 
            print('Project Title: ${projectMap['Project title']}');
            print('Date of Creation: ${projectMap['Date of Creation']}');
            print('Tasks: ${projectMap['Tasks']}');
            print('\n');
        
            
          }
          state = SuccessState(data: allProjects);
        } else {
          print('No projects found.');
        }
    }
    catch(error){
        state = const ErrorState('An error occured while getting the projects');
        rethrow; 
      }


        
      return  allProjects;


  }



   Future<void> deleteFileFromSharedPreferences(String nameOfJsonFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the key exists
    bool keyExists = prefs.containsKey(nameOfJsonFile);

    if (keyExists) {
      // Delete the key (file) from SharedPreferences
      prefs.remove(nameOfJsonFile);
      print('deleted $nameOfJsonFile');
    } else {
      print('$nameOfJsonFile does not exist in SharedPreferences.');
    }
  }

    Future<void> deleteNameFromSharedPreferences(String name, String nameOfJsonFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string from SharedPreferences
    // String? jsonString = prefs.getString('testMap');
    // String? jsonString = prefs.getString('liveTraining');
    String? jsonString = prefs.getString(nameOfJsonFile);
    if (jsonString != null) {
      // Parse the JSON string into a Map
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Remove the desired key from the Map
      // jsonMap.remove('Imran');
      jsonMap.remove(name);

      // Serialize the Map back into a JSON string
      String updatedJsonString = json.encode(jsonMap);

      // Save the updated JSON string back into SharedPreferences
      // prefs.setString('testMap', updatedJsonString);
      // prefs.setString('liveTraining', updatedJsonString);
      prefs.setString(nameOfJsonFile, updatedJsonString);

      print('Deleted $name from $nameOfJsonFile');
    } else {
      print('Name does not exist in $nameOfJsonFile');
    }
  }


}