import 'package:get/get.dart';
import 'package:todo_app_comp/models/task.dart';
import 'package:todo_app_comp/services/task_storage_manager.dart';

class TaskController extends GetxController {
  TaskStorageManager taskStorageManager = TaskStorageManager();
  var taskList = <Task>[].obs;
  var filteredTaskList = <Task>[].obs;


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
    taskList = taskStorageManager.getTaskList().obs;
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
