
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_management_app/utils/announcement_widget.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
  // NotificationScreen({super.key, required this.projectName, required this.listOfTasks});


}


// 2. extend [ConsumerState]
class _NotificationScreenState extends ConsumerState<NotificationScreen> {



  @override
  void initState() {
    super.initState();



  }




  @override
  Widget build(BuildContext context) {
    // 4. use ref.watch() to get the value of the provider

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Announcements',
          style: TextStyle(
              color: Colors.black45,
              fontSize: 30.0,
              fontWeight: FontWeight.bold
          ),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [

          AnnouncementWidget(),
        ],
      ),
    );
  }


}