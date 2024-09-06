import 'package:get_storage/get_storage.dart';
import 'package:todo_app_comp/models/task.dart';

class TaskStorageManager {
  var taskStorage = GetStorage('TaskStorage');

  void saveTaskList(List<Task> newTaskList) {
    taskStorage.write(StorageKey.taskList.name, newTaskList);
  }

  List<Task> getTaskList() {
    List<Task> taskList = taskStorage.read(StorageKey.taskList.name);
    return taskList ?? <Task>[];
  }

  void removeTaskList(int index) {
    List<Task> taskList = getTaskList();
    taskList.removeAt(index);
    saveTaskList(taskList);
  }
}

enum StorageKey { taskList }