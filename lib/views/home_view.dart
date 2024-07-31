


import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/models/project_model/project_model.dart';
import 'package:project_management_app/models/task_model/task_model.dart';

import 'package:project_management_app/view_models/project_view_model.dart';
import 'package:project_management_app/views/project_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;



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

   

     final projectState = ref.watch( projectViewModelProvider);
     final projectController = ref.watch( projectViewModelProvider.notifier);


    DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


   return  Scaffold(

     body: Padding(
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
               Container(
                 height: 70.0,
                 width: 70.0,
                 color: Colors.blueAccent,
                 ),
                const SizedBox(width: 10.0,),
                 Column(
                   children: [
                   const Text('Hi, Imran',
                     style: TextStyle(
                     fontWeight: FontWeight.bold, fontSize: 20.0),
                   ),
                        Text(formattedDate),
                   ],
                 ),
             ],
           ),
             
           const SizedBox(height: 20.0,),
         
           headings('Projects'),




           (projectState is SuccessState)?horizontalSlider(projectState.data): horizontalSlider(projectList ),

          

         







         
         
           
          
          
         
         
         
         
           const SizedBox(height: 20.0,),
         
           headings("Today's Tasks"),
         
           todayTaskList(),
         
            ],
          ),


           if (projectState is LoadingState) // Conditionally display CircularProgressIndicator
              const Center(
                child: CircularProgressIndicator(),
              ),



        ],
       ),
       
    ),


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
              },
            ),
            const SizedBox(width: 40), // This creates space for the round button
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle press
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Handle press
              },
            ),
          ],
        ),
      ),
      floatingActionButton: add(context,_formKey, projectController, projectState,projectList ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
   
    
   
    
    
  }


Widget add(BuildContext context,GlobalKey<FormState> formKey, ProjectViewModelNotifier projectController, final projectState,List<Project> list){
  // List<Project> list = [];
    return  FloatingActionButton(
      backgroundColor: Colors.blue,
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
                    projectController.deleteFileFromSharedPreferences('project_file');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete the file'),
                ),
                
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Validation passed, proceed with saving
                      // DateTime now = DateTime.now();
                      // int id = now.millisecondsSinceEpoch;
                      // String formattedDate = DateFormat('dd MMM yyyy').format(now);


                      String title = titleController.text;
                      String description = descriptionController.text;

                      Map<String,dynamic> newProject = {
                        "project_name" : title,
                        "description": description,
                      };
                      // Perform save operation or any other logic here
                      // projectController.saveOrUpdateJsonInSharedPreferences(id, title, formattedDate, description);
                      // if(projectState is SuccessState){
                      //    list = projectState.data;
                      // }

                      projectController.addProject(list, newProject);
                    


                      // print('Title: $title, Description: $description, Date: $formattedDate');
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


Widget horizontalSlider( List<Project> projectsList){
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
            onTap: (){

              List<Task>? taskList = [];


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProjectScreen(
                  projectName:listOfProjects[index].name,
                  projectId: listOfProjects[index].id,
                  // projectName:projectsList[index].name,
                  // projectId: projectsList[index].id,
                  taskList: taskList,)),
              );
            },




            child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red,
              ),
              child:  Center(
                child: Text(
                 // projectsList[index].name,
                  listOfProjects[index].name,
                  style: const  TextStyle(color: Colors.white, fontSize: 20.0),
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

Widget todayTaskList(){
  return  Expanded(
         child: ListView.builder(
          itemCount: 15, // Number of items
          itemBuilder: (context, index) {
            return Container(
              height: 50, // Adjust height as needed
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
            ),
              margin: const EdgeInsets.all(5), // Add margin for spacing
              alignment: Alignment.center,
              child: Text(
                'Item ${index + 1}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          },
               ),
       );
}



// Widget headings(String projectOrTask) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 5.0),
//         child: Text(
//          projectOrTask,
//           style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(right: 10.0),
//         child: GestureDetector(
//           onTap: () {
//             // Navigate to see all page or perform desired action
//           },
//           child: const Text(
//             'See all',
//             style: TextStyle(color: Colors.blue, fontSize: 16.0),
//           ),
//         ),
//       ),
//     ],
//   );
// }
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





