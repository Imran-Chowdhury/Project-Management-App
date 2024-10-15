


class Task {
  final int id;
  final String taskTitle;
  final String date;
  final bool completed;
  final projectId;
  final deadline;

  Task({required this.deadline, required this.id, required this.taskTitle, required this.date, required this.completed, required this.projectId});

  Task copyWith({
    int? id,
    String? nameOfTask,
    String? createdOn,
    bool? completed,
    projectId,
    deadline
  }) {
    return Task(
      id: id ?? this.id,
      taskTitle: nameOfTask ?? taskTitle,
      date: createdOn ?? date,
      completed: completed ?? this.completed,
      projectId: projectId ?? this.projectId,
      deadline: deadline ?? this.deadline,
    );
  }


factory Task.fromjson(Map<String, dynamic> taskJson ){
  return Task(
      id: taskJson['id'],
      taskTitle: taskJson['task_name'],
      date: taskJson['created_on'],
      completed:taskJson['completed'],
      projectId: taskJson['project_id'],
      deadline: taskJson['deadline'],
  );
}


}

