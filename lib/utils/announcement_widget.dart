


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnnouncementWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<AnnouncementWidget> createState() => _AnnouncementWidgetState();



}


// 2. extend [ConsumerState]
class _AnnouncementWidgetState extends ConsumerState<AnnouncementWidget> {


  @override
  void initState() {
    super.initState();

  }







  @override
  Widget build(BuildContext context) {
    // 4. use ref.watch() to get the value of the provider

    return  Expanded(
      child: ListView.builder(
        itemCount: 15, // Number of items
        itemBuilder: (context, index) {
          return Row(
            children: [
              const Icon(Icons.arrow_forward_ios),
              Column(children: [
                Material(
                  // color: Color(0xFFD1BABA),
                  color:const Color(0xFFE8A99B),
                  elevation: 8.0, // Set the elevation
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 100,
                    width: 330,// Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: const LinearGradient(colors: [Color(0xFFE8A99B),Color(0xFFE8A99B),]),
                      // color: Color(0xFFD1BABA),
                    ),
                    margin: const EdgeInsets.all(5), // Add margin for spacing
                    alignment: Alignment.center,
                    child: const Text(
                      'To be implemented',
                      style:  TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
              ],),
            ],
          );
        },
      ),
    );
  }


}