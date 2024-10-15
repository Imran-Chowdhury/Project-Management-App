import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_management_app/widgets/custom_textfield.dart';

import '../models/project_model/project_model.dart';
import '../utils/search_result_widget.dart';

import '../view_models/search_view_model.dart';


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
      resizeToAvoidBottomInset: true,
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
            padding: const EdgeInsets.fromLTRB(30,20,30,16),
            child: TextFormField(
              onChanged: (value) {
                controller.filterProjects(value, widget.allProjects);
              },
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter project name',

                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0XFFD3D3D3),
                prefixIcon: Icon(Icons.search_sharp),
              ),
            ),
          ),


         filteredProjects.isNotEmpty? Expanded(
            child: Stack(
              children: [
                // Yellow background container
                Positioned(
                  top: height * 0.05, // Adjust the height to start the background higher
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
          ):SizedBox(),
        ],
      ),
    );
  }
}



