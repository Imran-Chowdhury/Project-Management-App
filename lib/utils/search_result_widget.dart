


import 'package:flutter/material.dart';
import 'package:project_management_app/views/search_view.dart';

import '../models/project_model/project_model.dart';
import '../views/project_view.dart';

Widget searchResultTile(List<Project> filteredProjects, int index, BuildContext context , int userId, String accessToken){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        // showOptions(context, taskList[index].taskTitle, taskController, taskList, index, taskList[index].id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ProjectScreen(
            projectName:filteredProjects[index].name,
            description:filteredProjects[index].description,
            projectId: filteredProjects[index].id,
            userId: userId ,
            accessToken: accessToken,
          )),
        );
      },
      child: Material(
        elevation: 8.0, // Set the elevation
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            // color: const Color(0XFFAEBE25),
            // color:  Colors.blue,
            gradient: const LinearGradient(colors: [
              Color(0xFF912209),Color(0xFFC74426)
            ]),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 120,
          width: 320,


          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

            title: Text(filteredProjects[index].name,
              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
            subtitle: Text(filteredProjects[index].description,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400,)),

          ),
        ),
      ),
    ),
  );
}