




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/base_state/base_state.dart';
import 'package:project_management_app/models/task_model/task_model.dart';
import 'package:project_management_app/utils/background_widget.dart';

import 'package:project_management_app/view_models/task_view_model.dart';
import 'package:project_management_app/views/pie_chart.dart';





class ProjectScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
  ProjectScreen({super.key, required this.accessToken, required this.description, required this.projectName,required this.projectId});

  String projectName;
  String description;
  String accessToken;
  int projectId;
  // int userId;

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
    final taskController = ref.read(taskViewModelProvider(widget.projectId).notifier);
    widget.taskList = await taskController.getTasks(
        widget.projectId.toString(), widget.accessToken);
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
    final Size size = MediaQuery. of(context).size;
    double width = size.width;
    double height = size.height;

    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: const Text('Tasks',
            style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: const Color(0XFFD3D3D3),
        ),
        backgroundColor: Colors.white,
        body: PageView(
          children: [
            Stack( // Wrap the Column with a Stack
              children: [
                // BackgroudContainer(image: "assets/images/tasks.jpg",),
                // BackgroundContainer(),

                Padding(
                  padding: EdgeInsets.only(top: height*0.2),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
                      // color: Color(0XFFffffff),
                      color: Color(0XFFffda21),
                    ),
                    width: double.infinity,
                    height: height*0.8,

                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.projectName,
                        style: const TextStyle(
                            // color: Colors.black45,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 20.0,
                            // fontWeight: FontWeight.bold
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
      ),
    );
  }


  Widget add(BuildContext context, GlobalKey<FormState> formKey,
      TaskViewModelNotifier taskController, List<Task>? taskList,
      String projectTitle, ) {
    return FloatingActionButton(
      backgroundColor: const Color(0XFFD3D3D3),
      shape: const CircleBorder(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController titleController = TextEditingController();


            return TaskDialog(
                  taskList: widget.taskList,
                  projectId: widget.projectId.toString(),
                  accessToken: widget.accessToken,
                  taskController: taskController
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
                  taskController.toggleTaskCompletion(taskList,index,taskList[index],
                      widget.projectId.toString());
                },
                checkColor: Colors.white,
                activeColor: Colors.green,

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
                        color:const Color(0XFFF5F5DC),
                        // color:Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 120,
                      width: 320,


                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                        title: Text(
                          taskList[index].taskTitle,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle:  Column(
                          children: [
                           const Row(
                              children: <Widget>[
                                Icon( Icons.priority_high, color: Colors.grey),
                                Text(" Priority: High", style: TextStyle(color: Colors.black)),

                              ],
                            ),
                          const  SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                               const Icon(Icons.calendar_today, color: Colors.grey, size: 20,),
                                const  SizedBox(
                                  width: 10,
                                ),
                                Text('Deadline: ${taskList[index].deadline}', style: const TextStyle(color: Colors.black)),
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
        : const SizedBox(width: 1,height: 1,);
    // const Center(child: Text('Add a task'));,

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
                taskController.deleteTask(listOfTasks, index, taskID.toString(), widget.projectId.toString());
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



                taskController.updateTask(listOfTasks, index, updatedTask, taskID.toString(),widget.projectId.toString());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}



class TaskDialog extends StatefulWidget {
  final List<Task> taskList;
  final String projectId;
  final String accessToken;
  TaskViewModelNotifier taskController;

 TaskDialog({
    Key? key,
    required this.taskList,
    required this.projectId,
    required this.accessToken,
    required this.taskController
  }) : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  DateTime? selectedDate;

  // Date picker method
  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Prevents selection of past dates
      lastDate: DateTime(2101),
      helpText: 'Select Deadline Date',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        deadlineController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new task'),
      contentPadding: const EdgeInsets.all(24),
      content: Form(
        key: formKey,
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
            TextFormField(
              controller: deadlineController,
              decoration: const InputDecoration(
                hintText: 'Pick Deadline Date',
              ),
              readOnly: true,
              onTap: () {
                _selectDate(context); // Open date picker on tap
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please select a deadline date';
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
              String deadline = deadlineController.text.trim();

              Map<String, dynamic> newTask = {
                "task_name": title,
                "completed": false,
                "deadline": deadline, // Add the deadline to the task data
              };

              widget.taskController.addTask(widget.taskList, newTask,
                  widget.projectId.toString(), widget.accessToken);

              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
