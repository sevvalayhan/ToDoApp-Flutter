import 'package:get/get.dart';
import 'package:todo_app_comp/models/task.dart';
import 'package:todo_app_comp/priority.dart';
import 'package:todo_app_comp/services/task_storage_manager.dart';

class TaskController extends GetxController {
  TaskStorageManager taskStorageManager = TaskStorageManager();
  var taskList = <Task>[].obs;
  var filteredTaskList = <Task>[].obs;
  var task = Task(
    id: DateTime.now().microsecondsSinceEpoch,
    taskName: '',
    taskDescription: '',
    isCompleted: false,
    priority: Priority.low,
    date: DateTime.now().add(const Duration(days: 1)),
  ).obs;

  @override
  void onInit() {
    super.onInit();
  }

  void addTask(Task newTask) {
    taskList.add(newTask);
    saveTaskList();
  }

  void deleteTask(Task deletedTask) {
    taskList.remove(deletedTask);
    saveTaskList();
  }

  void updateTask(int index, Task newTask) {
    taskList[index] = newTask;
    saveTaskList();
  }

  void fetchTaskList() {
    var tasks = taskStorageManager.getTaskList();
    print("Task list before assignment: ${taskList}");
    taskList.value = tasks.isNotEmpty ? tasks : <Task>[];
    print("Task list after assignment: ${taskList}");
  }

  void saveTaskList() {
    taskStorageManager.saveTaskList(taskList);
  }

  void removeTaskList(int index) {
    taskStorageManager.removeTaskList(index);
  }

  void changeCheckBox(int index) {
    // int taskIndex = taskController.taskList
    //     .indexOf(taskController.filteredTaskList[index]);
    taskList[index].isCompleted = !taskList[index].isCompleted;
    saveTaskList();
  }
}
