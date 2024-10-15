
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project_model/project_model.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, List<Project>>((ref) {
  return SearchNotifier();
});


class SearchNotifier extends StateNotifier<List<Project>> {


  SearchNotifier() : super([]);

  void resetState(){
    state = [];
  }




  void filterProjects(String query, List<Project> projects) {
    if (query.isEmpty) {
      state = projects;
    } else {
      state = projects
          .where((project) => project.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

}
