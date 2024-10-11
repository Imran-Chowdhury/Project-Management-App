


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

  @override
  void initState() {

    super.initState();

    print('this is initstate');

   getProjects();
   // print(projectList);
  }
  Future<void> getProjects()async{
    final projectController =  ref.read(projectViewModelProvider.notifier);
    projectList = await projectController.getProjects();
  }


 


  @override
  Widget build(BuildContext context) {


     String userName = '';
     String refreshToken = '';
     final projectState = ref.watch( projectViewModelProvider);
     final projectController = ref.watch( projectViewModelProvider.notifier);
     final profileState = ref.read(profileViewModelProvider);
     if(profileState is ProfileSuccessState){
       userName = profileState.data.name;
       refreshToken = profileState.data.tokens['refresh'];
       print(userName);
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

       body:
      //  Padding(
      //    padding: const EdgeInsets.all(20.0),
      //    child: (projectState is LoadingState) ?
      //    const Center(
      //             child: CircularProgressIndicator(),
      //           )  :    Stack(
      //      children: [
      //       Column(
      //      children: [
      //        Row(
      //          children: [
      //            Container(
      //              height: 70.0,
      //              width: 70.0,
      //              color: Colors.blueAccent,
      //              ),
      //             const SizedBox(width: 10.0,),
      //              Column(
      //                children: [
      //                const Text('Hi, Imran',
      //                  style: TextStyle(
      //                  fontWeight: FontWeight.bold, fontSize: 20.0),
      //                ),
      //                     Text(formattedDate),
      //                ],
      //              ),
      //          ],
      //        ),
      //
      //        const SizedBox(height: 20.0,),
      //
      //        headings('Projects'),
      //
      //
      //
      //
      //        (projectState is SuccessState)?horizontalSlider(projectState.data, projectController):
      //        horizontalSlider(projectList,projectController ),
      //
      //
      //
      //
      //        const SizedBox(height: 20.0,),
      //
      //        headings("Today's Tasks"),
      //
      //        todayTaskList(),
      //
      //         ],
      //       ),
      //
      //
      //        if (projectState is LoadingState) // Conditionally display CircularProgressIndicator
      //           const Center(
      //             child: CircularProgressIndicator(),
      //           ),
      //
      //
      //
      //     ],
      //    ),
      //
      // ),
         Stack(
           children: [


            // BackgroudContainer( image: "assets/images/home.jpg",),
            //  BackgroudContainer(),
             Padding(
             padding: const EdgeInsets.all(20.0),
             child: (projectState is LoadingState) ?
             const Center(
               child: CircularProgressIndicator(),
             )  :    Stack(
               children: [
                 Column(
                   children: [
                     Row(
                       children: [
                        const Icon(
                             Icons.person,
                         size: 70,),


                         const SizedBox(width: 10.0,),
                         Column(
                           children: [
                             Text('Hi, $userName',
                               style: const TextStyle(
                                   fontWeight: FontWeight.bold, fontSize: 20.0),
                             ),
                             Text(formattedDate),
                           ],
                         ),
                         const SizedBox(width: 120.0,),
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
                         )


                       ],
                     ),

                     const SizedBox(height: 20.0,),

                     headings('Projects'),




                     (projectState is SuccessState)?horizontalSlider(projectState.data, projectController):
                     horizontalSlider(projectList,projectController ),




                     const SizedBox(height: 20.0,),

                     headings("Announcements"),

                     // announcements(),

                     AnnouncementWidget(width:width, height: height,),
                   ],
                 ),


                 if (projectState is LoadingState) // Conditionally display CircularProgressIndicator
                   const Center(
                     child: CircularProgressIndicator(),
                   ),



               ],
             ),
           ),
         ],),

        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  // Handle press
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Handle press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SearchScreen(allProjects: projectList,)),
                  );
                },
              ),
              const SizedBox(width: 40), // This creates space for the round button
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  NotificationScreen()),
                  );

                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: ()async {
                  // Handle press
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                },
              ),
            ],
          ),
        ),
        floatingActionButton: add(context,_formKey, projectController, projectState,projectList ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
   );
  }


Widget add(BuildContext context,GlobalKey<FormState> formKey, ProjectViewModelNotifier projectController, final projectState,List<Project> list){
  // List<Project> list = [];
    return  FloatingActionButton(
      backgroundColor: Colors.pink,
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

                      Map<String,dynamic> newProject = {
                        "project_name" : title,
                        "description": description,
                      };


                      projectController.addProject(list, newProject);

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
      child: const Icon(Icons.add),
    );
}


Widget horizontalSlider( List<Project> projectsList, ProjectViewModelNotifier projectController){
//   Widget horizontalSlider(final projectState){
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
                  projectController, listOfProjects, index, listOfProjects[index].id);
            },
            onTap: (){

              List<Task>? taskList = [];


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProjectScreen(
                  projectName:listOfProjects[index].name,
                  projectId: listOfProjects[index].id,
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
                  gradient: const LinearGradient(colors: [
                    // Color(0xFF88a03d),
                    // Color(0xFFC5C547)
                    Color(0xFF912209),Color(0xFFC74426)
                    ]),
                    //
                  // color: const Color(0xFF88a03d), // Container color
                  // color: const Color(0xFFC5C547), // Container color


                  borderRadius: BorderRadius.circular(20.0), // Same as Material's borderRadius
                ),
                 child:  Center(
                   child: Text(

                    listOfProjects[index].name,
                    style: const  TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 25.0),
                   ),
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
      ): const Center(child: Text('Start by adding a project'),);
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
       List<Project> listOfProjects,int index,  int projectID) {
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
                 projectController.deleteProject(listOfProjects, index, projectID.toString());
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



                 projectController.updateProject(listOfProjects, index, updatedTask, taskID.toString());

                 Navigator.of(context).pop();
               },
             ),
           ],
         );
       },
     );
   }

}




