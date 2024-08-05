



import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model/task_model.dart';

class PieChartScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<PieChartScreen> createState() => _PieChartScreenState();
  PieChartScreen({super.key, required this.projectName, required this.listOfTasks});

  String projectName;
  List<Task> listOfTasks;
}


// 2. extend [ConsumerState]
class _PieChartScreenState extends ConsumerState<PieChartScreen> {

  double completedTasks = 0;
  double inCompletedTasks = 0;
  String remarks = '';
  double efficiency = 0;

  @override
  void initState() {
    super.initState();
    getNumbersForChart();


  }

  void getNumbersForChart(){
    for(int i = 0; i<widget.listOfTasks.length;i++){
      if(widget.listOfTasks[i].completed){
        completedTasks = completedTasks + 1;
      }
    }
    inCompletedTasks = widget.listOfTasks.length - completedTasks;
  }

  double calculateEfficiency() {

    int totalTasks = widget.listOfTasks.length;
     efficiency = (completedTasks / totalTasks) * 100;
    // if(efficiency>=0.3){
    //   remarks = 'Need to improve on completing tasks';
    // }else if(0.3<efficiency<50){}

    return double.parse(efficiency.toStringAsFixed(1));

  }



  @override
  Widget build(BuildContext context) {
    // 4. use ref.watch() to get the value of the provider

    return  Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topCenter,
            child: Center(
              child: Text(
                widget.projectName,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0), // Adjust this value to move the chart upward
                  child: PieChart(
                    swapAnimationCurve: Curves.easeInOut,
                    swapAnimationDuration: const Duration(milliseconds: 700),
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 90,
                        sections: showingSections(completedTasks, inCompletedTasks), // Dummy values for completed and incomplete tasks
                    ),
                  ),
                ),


               const  Center(
                  child: Text(
                    'Progress Report',
                    style:  TextStyle(
                      color: Colors.black45,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Space for legends and efficiency display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Legend(color: Colors.blue, text: 'Work Done'),
              const SizedBox(width: 10),
              Legend(color: Colors.red, text: 'Undone Work'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Efficiency: ${calculateEfficiency()}%', // Dummy values for completed and incomplete tasks
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


    //   Scaffold(
    //   backgroundColor: Colors.white10,
    //   body: Column(
    //     children: [
    //       const SizedBox(height: 20,),
    //       Align(
    //         alignment: Alignment.topCenter,
    //         child: Center(
    //           child: Text(
    //             widget.projectName,
    //
    //             style: const TextStyle(
    //                 color: Colors.black45,
    //                 fontSize: 30.0,
    //                 fontWeight: FontWeight.bold
    //             ),
    //           ),
    //         ),
    //       ),
    //
    //       Expanded(
    //         child: PieChart(
    //           swapAnimationCurve: Curves.easeInOut,
    //           swapAnimationDuration: const Duration(milliseconds: 700),
    //           PieChartData(
    //             sectionsSpace: 4,
    //             centerSpaceRadius: 90,
    //             sections: showingSections(completedTasks, inCompletedTasks),
    //           ),
    //         ),
    //       )
    //
    //     ],
    //   )
    // );
  }

  List<PieChartSectionData> showingSections(double completedTasks, double inCompletedTasks) {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: completedTasks,
        title: completedTasks.toString(),
        radius: 50,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: inCompletedTasks,
        title: inCompletedTasks.toString(),
        radius: 50,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      // PieChartSectionData(
      //   color: Colors.green,
      //   value: 25,
      //   title: '25%',
      //   radius: 50,
      //   titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      // ),
      // PieChartSectionData(
      //   color: Colors.yellow,
      //   value: 15,
      //   title: '15%',
      //   radius: 50,
      //   titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      // ),
      // PieChartSectionData(
      //   color: Colors.purple,
      //   value: 10,
      //   title: '10%',
      //   radius: 50,
      //   titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      // ),
    ];
  }
// }


class Legend extends StatelessWidget {
  final Color color;
  final String text;

  Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
