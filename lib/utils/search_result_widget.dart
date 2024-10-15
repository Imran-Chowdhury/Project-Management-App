


import 'package:flutter/material.dart';
import '../models/project_model/project_model.dart';
import '../views/project_view.dart';

// Widget searchResultTile(List<Project> filteredProjects, int index, BuildContext context, String accessToken){
//   final Size size = MediaQuery.of(context).size;
//   double width = size.width;
//   double height = size.height;
//   return  Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: GestureDetector(
//       onTap: () {
//         // showOptions(context, taskList[index].taskTitle, taskController, taskList, index, taskList[index].id);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) =>  ProjectScreen(
//             projectName:filteredProjects[index].name,
//             description:filteredProjects[index].description,
//             projectId: filteredProjects[index].id,
//
//             accessToken: accessToken,
//           )),
//         );
//       },
//       child: Material(
//         elevation: 8.0, // Set the elevation
//         borderRadius: BorderRadius.circular(20.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color:const Color(0XFFF5F5DC),
//             // color:  Colors.blue,
//
//             borderRadius: BorderRadius.circular(20),
//           ),
//           height: height*.2,
//           width: width*.8,
//
//
//
//           child: Center(
//             child: ListTile(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//
//               title: Text(filteredProjects[index].name,
//                 style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20),),
//               subtitle: Text(filteredProjects[index].description,
//                   style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w400,),
//               ),
//
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget searchResultTile(List<Project> filteredProjects, int index, BuildContext context, String accessToken) {
  final Size size = MediaQuery.of(context).size;
  double width = size.width;
  double height = size.height;

  return Padding(
    padding: const EdgeInsets.only(left: 30.0,right: 30, bottom: 12,),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectScreen(
              projectName: filteredProjects[index].name,
              description: filteredProjects[index].description,
              projectId: filteredProjects[index].id,
              accessToken: accessToken,
            ),
          ),
        );
      },
      child: Material(
        elevation: 8.0, // Set the elevation
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFFF5F5DC),
            borderRadius: BorderRadius.circular(30),
          ),
          height: height * 0.2,
          width: width * 0.8, // Ensure dynamic width

          child: Center(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(
                filteredProjects[index].name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                maxLines: 2, // Limit to 2 lines if needed
                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
              ),
              subtitle: Text(
                filteredProjects[index].description,
                style: const TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 3, // Limit to 3 lines if needed
                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
