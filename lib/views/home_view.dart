

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/views/project_view.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

 


  @override
  
  Widget build(BuildContext context, WidgetRef ref) {

  DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    
    return  Scaffold(

     body:  Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
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
    
    
      horizontalSlider(),
     
    
    
     const SizedBox(height: 20.0,),
    
      headings("Today's Tasks"),
    
    
     todayTaskList(),
         
       
    
       ],
     ),
     ),


      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle press
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle press
              },
            ),
            SizedBox(width: 40), // This creates space for the round button
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle press
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Handle press
              },
            ),
          ],
        ),
      ),
      floatingActionButton: add(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


Widget add(BuildContext context){
    return  FloatingActionButton(
      backgroundColor: Colors.blue,
      shape: const CircleBorder(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController textEditingController = TextEditingController();
            // textEditingController.text = items[index];
            return AlertDialog(
              title: const Text('Add a new Project'),
              content: TextField(
                controller: textEditingController,
                onChanged: (value) {
                  // You can add validation if needed
                },
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
                    String newText = textEditingController.text;
                    // updateItem(index, newText);
                    Navigator.of(context).pop();
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



Widget horizontalSlider(){
  return  CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return GestureDetector(
            onTap: (){

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProjectScreen()),
              );
            },




            child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue,
              ),
              child: const Center(
                child: Text(
                  'HI',
                  style:  TextStyle(color: Colors.white, fontSize: 20.0),
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
      );
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
}
