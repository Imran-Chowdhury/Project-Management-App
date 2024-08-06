import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project_model/project_model.dart';
import '../utils/search_result_widget.dart';

import '../view_models/search_view_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
  SearchScreen({required this.allProjects});
  List<Project> allProjects;
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _searchController.addListener(() {
  //     ref.read(projectProvider.notifier).filterProjects(_searchController.text);
  //   });
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProjects = ref.watch(projectProvider);
    SearchNotifier controller = ref.watch(projectProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Projects',
            style: TextStyle(
            color: Colors.black45,
            fontSize: 30.0,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value){
                // controller.filteredProjects(value, widget.allProjects);
                controller.filterProjects(value, widget.allProjects);
              },
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter project name',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  return searchResultTile( filteredProjects, index, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


