


import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/base_state/profile_state.dart';
import 'package:project_management_app/models/project_model/project_model.dart';
import 'package:project_management_app/models/task_model/task_model.dart';
import 'package:project_management_app/utils/announcement_widget.dart';

import 'package:project_management_app/view_models/project_view_model.dart';
import 'package:project_management_app/views/announcement_view.dart';
import 'package:project_management_app/views/project_view.dart';
import 'package:project_management_app/views/search_view.dart';
import 'package:project_management_app/views/signin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

import '../utils/background_widget.dart';
import '../view_models/profile_view_model.dart';



class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {


  List<Project> projectList = [];
  String fileName = 'project_file';
  int userId = 0;
  String userName = '';
  String refreshToken = '';
  String accessToken = '';


  @override
  void initState() {
    super.initState();
    getProjects();
  }


  Future<void> getProjects() async {
    final projectController = ref.read(projectViewModelProvider.notifier);
    projectList = await projectController.getProjects();
  }

  // Future<void> getProjects() async {
  //   final projectController = ref.read(projectViewModelProvider.notifier);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Retrieve the JSON-encoded string from SharedPreferences
  //   String? profileString = prefs.getString('profile');
  //
  //   if (profileString != null) {
  //     // Decode the string back to a Map
  //     Map<String, dynamic> profileMap = await jsonDecode(profileString);
  //     userName = await profileMap['name'];
  //     accessToken = await profileMap['tokens']['access'];
  //     refreshToken = await profileMap['tokens']['refresh'];
  //     userId = await profileMap['id'];
  //     projectList = await projectController.getProjects(accessToken);
  //   }
  // }




  @override
  Widget build(BuildContext context) {

      // int userId = 0;
      // String userName = '';
      // String refreshToken = '';
      // String accessToken = '';
     final projectState = ref.watch( projectViewModelProvider);
     final projectController = ref.watch( projectViewModelProvider.notifier);
     final profileState = ref.read(profileViewModelProvider);

     if(profileState is ProfileSuccessState){
       userName = profileState.data.name;
       refreshToken = profileState.data.tokens['refresh'];
       accessToken = profileState.data.tokens['access'];
       userId =  profileState.data.id;
       print(userName);
       print(userId);
       print(accessToken);
     }


    DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final Size size = MediaQuery. of(context).size;
    double width = size.width;
    double height = size.height;



   return  PopScope(

     child: Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         title:const Text('Projects',style: TextStyle(fontWeight: FontWeight.bold),),
         backgroundColor:const Color(0XFFD3D3D3),

         actions: [

           IconButton(
             iconSize: 30.0, // Specify the size directly
             onPressed: () async {


               // After logout, navigate to SignInScreen or any desired screen
               await Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>SearchScreen(
                     allProjects: projectList, accessToken: accessToken)),

               );
             },
             icon: const Icon(
               Icons.search_sharp,
             ),
           ),
           IconButton(
             iconSize: 30.0, // Specify the size directly
             onPressed: () async {
               // Perform logout action here
               await ref.read(profileViewModelProvider.notifier).logout(refreshToken,context);

               // After logout, navigate to SignInScreen or any desired screen
               await Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(builder: (context) => SignInScreen()),
                     (route) => false, // This ensures the back button will exit the app
               );
             },
             icon: const Icon(
               Icons.exit_to_app_outlined,
             ),
           ),
         ],
       ),

       body: Stack(
           children: [

             BackgroundContainer(),
            Padding(
              padding: EdgeInsets.only(top: height*0.55),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
                  // color: Color(0XFFffffff),
                  color: Color(0XFFffda21),
                ),
                width: double.infinity,
                height: height*0.8,

              ),
            ),

             Padding(
               padding: const EdgeInsets.all(20),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    SizedBox(
                     height: height * .3,
                   ),
                   Text('Hi, $userName',
                     style: const TextStyle(
                         fontWeight: FontWeight.bold, fontSize: 20.0),
                   ),
                  const Text(
                      'Here are all your projects',
                    style: TextStyle(
                        fontSize: 14.0),
                  ),
                   const SizedBox(height: 10,),
                   (projectState is SuccessState)?horizontalSlider(accessToken,userId,height,projectState.data, projectController):
                   horizontalSlider(accessToken,userId,height,projectList,projectController ),

                   if (projectState is LoadingState) // Conditionally display CircularProgressIndicator
                     const Center(
                       child: CircularProgressIndicator(),
                     ),
                 ],
               ),
             ),

         ],
       ),


        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 25,bottom: 20),
          child: add(context,_formKey, projectController, projectState,projectList,userId.toString(),accessToken),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
   );
  }


Widget add(BuildContext context,GlobalKey<FormState> formKey, ProjectViewModelNotifier projectController, final projectState,List<Project> list, String userId, String accesstoken){
  // List<Project> list = [];
    return  FloatingActionButton(
      backgroundColor: const Color(0XFFD3D3D3),
      shape: const CircleBorder(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController titleController = TextEditingController();
            TextEditingController descriptionController = TextEditingController();

            return AlertDialog(
              title: const Text('Add a new Project'),
              contentPadding: const EdgeInsets.all(24), // Adjust padding for bigger size
              content: Form(
                key:  formKey,
                // mainAxisSize: MainAxisSize.min,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Project Title',
                      ),
                      validator: (value) {

                        if (value!.isEmpty) {
                          return 'Please enter a project title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      maxLength: 100,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Add Description',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please add a description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),


                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Validation passed, proceed with saving
                      String title = titleController.text.trim();
                      String description = descriptionController.text.trim();
                      print(userId);

                      Map<String,dynamic> newProject = {
                        "project_name" : title,
                        "description": description,
                        'user_id': userId,
                      };


                      projectController.addProject(list, newProject,accesstoken);

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.black45,
      ),
    );
}


Widget horizontalSlider(String accessToken,int userId, double height, List<Project> projectsList, ProjectViewModelNotifier projectController){
    //  Widget horizontalSlider(final projectState){
    // final projectState = ref.watch(projectViewModelProvider);
  List<Project> listOfProjects = projectsList;
  // if(projectState is SuccessState){
  //   listOfProjects = projectState.data;
  // }
  return listOfProjects.isNotEmpty? CarouselSlider.builder(
        // itemCount: projectsList.length,
        itemCount: listOfProjects.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return GestureDetector(
            onLongPress: (){
              showOptions(context, listOfProjects[index].name, listOfProjects[index].description,
                  projectController, listOfProjects, index, listOfProjects[index].id,accessToken);
            },
            onTap: (){

              List<Task>? taskList = [];


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProjectScreen(
                  projectName:listOfProjects[index].name,
                  description:listOfProjects[index].description,
                  projectId: listOfProjects[index].id,

                  accessToken: accessToken
                  )),
              );
            },




            child: Material(
              elevation: 8.0, // Set the elevation
              borderRadius: BorderRadius.circular(20.0), // Optional: Add rounded corners
              // shadowColor: Colors.black.withOpacity(0.5), // Optional: Customize the shadow color
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color:const Color(0XFFF5F5DC),

                  borderRadius: BorderRadius.circular(20.0), // Same as Material's borderRadius
                ),
                 child:  Column(
                   children: [
                     const SizedBox(height: 20,),
                    const Icon(
                       Icons.sticky_note_2_outlined,
                       size: 80,
                     ),

                     Center(
                       child: Text(

                         listOfProjects[index].name,
                         style: const  TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 25.0),
                       ),
                     ),
                   ],
                 ),
              ),
            ),






          );
        },
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          // enlargeFactor: 0.3 ,
          // disableCenter: true,
          viewportFraction: 0.7,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ): const Center(
        child: Text(
          'Opp! No projects found. Start by adding a project',
          // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
}


Widget headings(String projectOrTask) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
         projectOrTask,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            // Navigate to see all page or perform desired action
          },
          child: const Text(
            'See all',
            style: TextStyle(color: Colors.blue, fontSize: 16.0),
          ),
        ),
      ),
    ],
  );
}



   void showOptions(BuildContext context,String project,String description, ProjectViewModelNotifier projectController,
       List<Project> listOfProjects,int index,  int projectID,String accessToken) {
     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Wrap(
           children: <Widget>[
             ListTile(
               leading: const Icon(Icons.delete),
               title: const Text('Delete'),
               onTap: () {
                 // Handle delete logic
                 projectController.deleteProject(listOfProjects, index, projectID.toString(),accessToken);
                 Navigator.pop(context);
               },
             ),
             ListTile(
               leading: const Icon(Icons.edit),
               title: const Text('Edit'),
               onTap: () {
                 Navigator.pop(context);
                 showUpdateDialog(context, project, description, projectController, listOfProjects, index,projectID);
               },
             ),
           ],
         );
       },
     );
   }

   void showUpdateDialog(BuildContext context,String project,String description, ProjectViewModelNotifier projectController,
       List<Project> listOfProjects,int index, int taskID) {
     final TextEditingController nameController = TextEditingController(
         text: project);
     final TextEditingController descriptionController = TextEditingController(
         text: description);
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: const Text('Update Project'),
           content: Column(
             children: [
               TextField(
                 controller: nameController,
                 decoration: const InputDecoration(hintText: "Project name"),
               ),
               TextField(
                 controller: descriptionController,
                 decoration: const InputDecoration(hintText: 'Description'),
               ),
             ],
           ),
           actions: <Widget>[
             TextButton(
               child: const Text('Cancel'),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             ),
             TextButton(
               child: const Text('Update'),
               onPressed: () {

                 Map<String, dynamic> updatedTask =   {
                   "project_name" : nameController.text.trim(),
                   "description": descriptionController.text.trim(),
                 };



                 projectController.updateProject(listOfProjects, index, updatedTask, taskID.toString(),accessToken);

                 Navigator.of(context).pop();
               },
             ),
           ],
         );
       },
     );
   }

}




