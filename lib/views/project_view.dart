




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectScreen extends ConsumerWidget {



   ProjectScreen({super.key, required this.projectName});

  String projectName;


 


  @override
  
  Widget build(BuildContext context, WidgetRef ref) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
           const  SizedBox(height: 10.0,),
            Center(
              child: Text(
                projectName,
                style: const TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),

            tasks(),





            //  Positioned(
            //   bottom: 16,
            //   right: 20,
            //   child: FloatingActionButton(
            //     onPressed: null,
            //     child: Icon(Icons.add),
            //     backgroundColor: Colors.pinkAccent,
            //     shape: CircleBorder(),
            //   ),
            // ),
          ],
        ),
      ),
    ); 




  }


Widget tasks(){
  return  Expanded(
         child: ListView.builder(
          itemCount: 5, // Number of items
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
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
              ),
            );
          },
               ),
       );
}


}