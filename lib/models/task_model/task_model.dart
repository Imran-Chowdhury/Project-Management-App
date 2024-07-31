


class Task {
  final int id;
  final String taskTitle;
  final String date;
  final bool completed;
  final projectId;

  Task({required this.id, required this.taskTitle, required this.date, required this.completed, required this.projectId});

factory Task.fromjson(Map<String, dynamic> taskJson ){
  return Task(
      id: taskJson['id'],
      taskTitle: taskJson['task_name'],
      date: taskJson['created_on'],
      completed:taskJson['completed'],
      projectId: taskJson['project_id']
  );
}
// Map<String, dynamic> toJson(){
//   return{};
// }




}

