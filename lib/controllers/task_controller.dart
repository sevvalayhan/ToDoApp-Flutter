import 'package:get/get.dart';
import 'package:todo_app_comp/models/task.dart';
import 'package:todo_app_comp/services/task_services.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var filteredTaskList = <Task>[].obs;
  var isLoading = true.obs;
  final TaskServices _taskService = TaskServices();

  Future<void> getTasks() async {
    try {
      isLoading(true);
      var fetchedTasks = await _taskService.fetchTasks();
      tasks.value = fetchedTasks;
      filteredTaskList.value = tasks;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addTask(Task task) async {
    bool success = false;
    try {
      isLoading(true);
      success = await _taskService.addTask(task);
      print(success);
    } finally {
      isLoading(false);
      return success;
    }
  }

  Future<bool> updateTask(int id, Task task) async {
    bool success = false;
    try {
      isLoading(true);
      success = await _taskService.updateTask(id, task);
      return success;
    } finally {
      isLoading(false);
      return success;
    }
  }

  Future<bool> deleteTask(int id) async {
    bool success = false;
    try {
      isLoading(true);
      success = await _taskService.deleteTodo(id);
      return success;
    } finally {
      isLoading(false);
      return success;
    }
  }

  Future<void> changeCheckBox(int id) async {
    Task newTask = tasks.firstWhere((task) => task.id == id);
    newTask.isCompleted = !newTask.isCompleted;
    print(newTask.toJson());
    await updateTask(id, newTask);
    getTasks();
    print("check box");
  }
}
