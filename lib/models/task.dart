import 'package:todo_app_comp/priority.dart';

class Task {
  late int id;
  late String taskName;
  late String taskDescription;
  late bool isCompleted;
  late Priority priority;
  late DateTime date;

  Task({
     required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.priority,
    required this.isCompleted,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isCompleted': isCompleted,
      'priority': priority.toJson(),
      'date': date.toIso8601String(),
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['taskName'];
    taskDescription = json['taskDescription'];
    isCompleted = json['isCompleted'];
    priority = Priority.fromJson(json['priority']);
    date = DateTime.parse(json['date']);
  }
}
