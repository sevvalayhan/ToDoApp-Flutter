import 'package:intl/intl.dart';
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
      'title': taskName,
      'description': taskDescription,
      'is_complated': isCompleted,
      'priority': priority.toJson(),
      'date': DateFormat('yyyy-MM-dd').format(date).toString()
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['title'];
    taskDescription = json['description'];
    isCompleted = json['is_complated'];
    priority = Priority.fromJson(json['priority']);;
    date = DateTime.parse(json['date']);
  }
}
