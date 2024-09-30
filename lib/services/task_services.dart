import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app_comp/models/task.dart';

class TaskServices {
  final String baseUrl = 'http://127.0.0.1:8000/todoapi/';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('${baseUrl}gettodo'));
    if (response.statusCode == 200) {
      var fetchedTasksData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      List<Task> fetchedTasks =
          fetchedTasksData.map((t) => Task.fromJson(t)).toList();

      return fetchedTasks;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<bool> addTask(Task task) async {
    Map<String, dynamic> newTask = task.toJson();
    print("New Task(service): " + newTask.toString());
    final response = await http.post(
      Uri.parse('${baseUrl}add-task'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newTask),
    );
    return response.statusCode == 201;
  }

  Future<bool> updateTask(int id, Task task) async {
    print("*******************" + task.taskName);
    Map<String, dynamic> newTask = task.toJson();
    final response = await http.put(
      Uri.parse('${baseUrl}update-task/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newTask),
    );

    if (response.statusCode != 200) {
      print('Hata: ${response.body}');
    }
    return response.statusCode == 200;
  }

  Future<bool> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('${baseUrl}delete-task/$id'));
    return response.statusCode == 204;
  }
}
