


class Task {
  // final int id;
  final String taskTitle;
  final String date;

  Task({ required this.taskTitle, required this.date});

factory Task.fromjson(Map<String, dynamic> taskJson ){
  return Task(
     
       taskTitle: taskJson['Task Title'],
      
      date: taskJson['Date of Creation'],
  );
}
// Map<String, dynamic> toJson(){
//   return{};
// }




}

