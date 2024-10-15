import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_management_app/widgets/custom_textfield.dart';

import '../models/project_model/project_model.dart';
import '../utils/search_result_widget.dart';

import '../view_models/search_view_model.dart';

// class SearchScreen extends ConsumerStatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
//   SearchScreen({super.key, required this.allProjects, required this.accessToken});
//   List<Project> allProjects;
//   String accessToken;
// }
//
// class _SearchScreenState extends ConsumerState<SearchScreen> {
//   TextEditingController searchController = TextEditingController();
//
//
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final filteredProjects = ref.watch(projectProvider);
//     SearchNotifier controller = ref.watch(projectProvider.notifier);
//     final Size size = MediaQuery. of(context).size;
//     double width = size.width;
//     double height = size.height;
//
//     return Scaffold(
//       appBar:AppBar(
//         title: const Text('Search Projects',
//           style: TextStyle(fontWeight: FontWeight.bold),),
//         backgroundColor: const Color(0XFFD3D3D3),
//       ),
//       body: Column(
//         children: [
//
//          Padding(
//            padding: EdgeInsets.only(left: width*.17,top: height*.01),
//            child: Image.asset(
//                 'assets/images/login.png', // Your image path
//                 height: height * 0.3,
//               ),
//          ),
//
//           TextFormField(
//             onChanged: (value){
//               controller.filterProjects(value, widget.allProjects);
//             },
//             controller: searchController,
//             decoration:const  InputDecoration(
//               labelText: 'Search',
//               hintText: 'Enter project name',
//               border:  OutlineInputBorder(),
//             ),
//
//           ),
//
//
//
//
//
//           Stack(
//           children: [
//
//             Padding(
//               padding: EdgeInsets.only(top: height*0.4),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
//                   // color: Color(0XFFffffff),
//                   color: Color(0XFFffda21),
//                 ),
//                 width: double.infinity,
//                 height: height*0.9,
//
//               ),
//             ),
//
//             SizedBox(height: height*.05,),
//
//
//
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredProjects.length,
//                 itemBuilder: (context, index) {
//                   return searchResultTile(filteredProjects, index, context, widget.accessToken);
//                 },
//               ),
//             ),
//           ],
//         ),
//         ],
//       ),
//     );
//   }
// }


class SearchScreen extends ConsumerStatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
  SearchScreen({super.key, required this.allProjects, required this.accessToken});
  List<Project> allProjects;
  String accessToken;
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProjects = ref.watch(searchProvider);
    SearchNotifier controller = ref.watch(searchProvider.notifier);
    final Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFffffff),
      appBar: AppBar(
        title: const Text(
          'Search Projects',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0XFFD3D3D3),
      ),
      body: Column(
        children: [

          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/search.png', // Your image path
              height: height * 0.3,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (value) {
                controller.filterProjects(value, widget.allProjects);
              },
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter project name',
                border: OutlineInputBorder(),
              ),
            ),
          ),

         // filteredProjects.isEmpty? const Text(
         //   'Search for Projects',
         //   style: TextStyle(
         //       color: Colors.black45,
         //       fontWeight: FontWeight.bold,
         //       fontSize: 20
         //
         //   ),
         // ): SizedBox(),
          Expanded(
            child: Stack(
              children: [
                // Yellow background container
                Positioned(
                  top: height * 0.08, // Adjust the height to start the background higher
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Color(0XFFffda21),
                    ),
                    width: width, // Take full width
                    height: height * 0.75, // Cover most of the height for the container
                  ),
                ),
                // ListView inside the yellow container
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01), // Adjust the top padding to position ListView
                  child: ListView.builder(
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      return searchResultTile(filteredProjects, index, context, widget.accessToken);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



