




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/models/task_model/task_model.dart';

import 'package:project_management_app/view_models/task_view_model.dart';
import 'package:project_management_app/views/pie_chart.dart';


class ProjectScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
  ProjectScreen({super.key, required this.projectName,required this.projectId});

  String projectName;
  int projectId;
  List<Task> taskList = [];
}

// 2. extend [ConsumerState]
class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  @override
  void initState() {
    super.initState();

    getTasks();
  }

  Future<void> getTasks() async {
    print('bambam');
    final taskController = ref.read(
        taskViewModelProvider(widget.projectId).notifier);
    widget.taskList =
    await taskController.getTasks(widget.projectId.toString());
    print(widget.taskList);
  }


  @override
  Widget build(BuildContext context) {
    var taskState = ref.watch(taskViewModelProvider(widget.projectId));
    TaskViewModelNotifier taskController = ref.watch(
        taskViewModelProvider(widget.projectId).notifier);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String priority = 'High';
    DateTime? selectedDate;

    // 4. use ref.watch() to get the value of the provider
    // final helloWorld = ref.watch(helloWorldProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          children: [
            Stack( // Wrap the Column with a Stack
              children: [
                // BackgroudContainer(image: "assets/images/tasks.jpg",),
                // BackgroudContainer(),
                Column(
                  children: [
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Text(
                          widget.projectName,
                          style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    // (taskState is TaskSuccessState&&taskState.nameOfProject == projectName)?tasks(taskState.data): tasks(taskList),
                    (taskState is TaskSuccessState) ? tasks(taskState.data,taskController) : tasks(
                        widget.taskList,taskController),
                    //  tasks(taskList),

                  ],
                ),
                Positioned(
                  bottom: 16.0,
                  right: 20.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: add(context, formKey, taskController, widget.taskList,
                        widget.projectName, ),
                  ),
                ),
              ],
            ),

            (taskState is TaskSuccessState) ? PieChartScreen(projectName: widget.projectName,listOfTasks: taskState.data,):
            PieChartScreen(projectName: widget.projectName,listOfTasks: widget.taskList,),
          ],
        ),


        // Stack( // Wrap the Column with a Stack
        //   children: [
        //     // BackgroudContainer(image: "assets/images/tasks.jpg",),
        //     // BackgroudContainer(),
        //     Column(
        //       children: [
        //        const SizedBox(height: 20,),
        //         Align(
        //           alignment: Alignment.topCenter,
        //           child: Center(
        //             child: Text(
        //               widget.projectName,
        //               style: const TextStyle(
        //                 color: Colors.black45,
        //                 fontSize: 30.0,
        //                 fontWeight: FontWeight.bold
        //               ),
        //             ),
        //           ),
        //         ),
        //         // (taskState is TaskSuccessState&&taskState.nameOfProject == projectName)?tasks(taskState.data): tasks(taskList),
        //         (taskState is TaskSuccessState) ? tasks(taskState.data,taskController) : tasks(
        //             widget.taskList,taskController),
        //         //  tasks(taskList),
        //
        //       ],
        //     ),
        //     Positioned(
        //       bottom: 16.0,
        //       right: 20.0,
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: add(context, formKey, taskController, widget.taskList,
        //             widget.projectName, selectedDate!),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }


  Widget add(BuildContext context, GlobalKey<FormState> formKey,
      TaskViewModelNotifier taskController, List<Task>? taskList,
      String projectTitle, ) {
    return FloatingActionButton(
      backgroundColor: Colors.pinkAccent,
      shape: const CircleBorder(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController titleController = TextEditingController();
            // TextEditingController descriptionController = TextEditingController();

            return
              // AlertDialog(
              //   title: const Text('Add a new task'),
              //   contentPadding: const EdgeInsets.all(24),
              //   content: Form(
              //     key: formKey,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         TextFormField(
              //           controller: titleController,
              //           decoration: const InputDecoration(
              //             hintText: 'Enter Task',
              //           ),
              //           validator: (value) {
              //             if (value!.isEmpty) {
              //               return 'Please enter a task';
              //             }
              //             return null;
              //           },
              //         ),
              //         const SizedBox(height: 16),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Text("Priority"),
              //             RadioListTile<String>(
              //               title: const Text('High'),
              //               value: 'High',
              //               groupValue: 'High',
              //               onChanged: (value) {
              //               //   setState(() {
              //               //     priority = value!;
              //               //   });
              //               },
              //             ),
              //             RadioListTile<String>(
              //               title: const Text('Medium'),
              //               value: 'Medium',
              //               groupValue: 'Medium',
              //               onChanged: (value) {
              //                 // setState(() {
              //                 //   _priority = value!;
              //                 // });
              //               },
              //             ),
              //             RadioListTile<String>(
              //               title: const Text('Low'),
              //               value: 'Low',
              //               groupValue: 'Low',
              //               onChanged: (value) {
              //                 // setState(() {
              //                 //   _priority = value!;
              //                 // });
              //               },
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 16),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Text(
              //                 selectedDate == null
              //                     ? 'No deadline selected'
              //                     : 'Deadline: ${DateFormat.yMd().format(selectedDate!)}',
              //               ),
              //             ),
              //             TextButton(
              //               onPressed: () async {
              //                 DateTime? pickedDate = await showDatePicker(
              //                   context: context,
              //                   initialDate: DateTime.now(),
              //                   firstDate: DateTime.now(),
              //                   lastDate: DateTime(2101),
              //                 );
              //                 if (pickedDate != null) {
              //                   setState(() {
              //                     selectedDate = pickedDate;
              //                   });
              //                 }
              //               },
              //               child: const Text('Select deadline'),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),






              AlertDialog(
              title: const Text('Add ta new task'),
              contentPadding: const EdgeInsets.all(24),
              // Adjust padding for bigger size
              content: Form(
                key: formKey,
                // mainAxisSize: MainAxisSize.min,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Task',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a task';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                  ],
                ),
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
                    if (formKey.currentState!.validate()) {
                      // Validation passed, proceed with saving


                      String title = titleController.text.trim();


                      Map<String, dynamic> newTask = {
                        "task_name": title,
                        "completed": false
                      };


                      taskController.addTask(widget.taskList, newTask,
                          widget.projectId.toString());

                      Navigator.of(context).pop();
                    }
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

  Widget tasks(List<Task> taskList, TaskViewModelNotifier taskController) {
    return taskList.isNotEmpty
        ? Expanded(
      child: ListView.builder(
        itemCount: taskList.length, // Number of items
        itemBuilder: (context, index) {
          return Row(
            children: [
              Checkbox(
                value: taskList[index].completed,
                onChanged: (bool? value) {
                  taskController.toggleTaskCompletion(taskList,index,taskList[index]);
                },
                checkColor: Colors.white,
                activeColor: Colors.pink,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onLongPress: () {
                    showOptions(context, taskList[index].taskTitle, taskController, taskList, index, taskList[index].id);
                  },
                  child: Material(
                    elevation: 8.0, // Set the elevation
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0XFFAEBE25),
                        // color:  Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 120,
                      width: 320,


                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                        title: Text(
                          taskList[index].taskTitle,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Icon( Icons.priority_high, color: Colors.yellow),
                                Text(" Priority: High", style: TextStyle(color: Colors.white)),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.calendar_today, color: Colors.yellow, size: 20,),

                                Text(" Put deadline here", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    )
        : const Center(child: Text('Add a task'));
  }




  void showOptions(BuildContext context,String task, TaskViewModelNotifier taskController,
      List<Task> listOfTasks,int index,  int taskID) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                // Handle delete logic
                taskController.deleteTask(listOfTasks, index, taskID.toString());
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update'),
              onTap: () {
                Navigator.pop(context);
                showUpdateDialog(context, task, taskController, listOfTasks, index,taskID);
              },
            ),
          ],
        );
      },
    );
  }

  void showUpdateDialog(BuildContext context,String task,TaskViewModelNotifier taskController,
      List<Task> listOfTasks,int index, int taskID) {
    final TextEditingController controller = TextEditingController(
        text: task);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Task'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Task name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {

                Map<String, dynamic> updatedTask =   {
                  "task_name": controller.text.trim(),
                  "completed": false
                };



                taskController.updateTask(listOfTasks, index, updatedTask, taskID.toString());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
