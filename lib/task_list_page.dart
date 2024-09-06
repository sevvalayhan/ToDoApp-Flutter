import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_comp/constants/colors.dart';
import 'package:todo_app_comp/controllers/task_controller.dart';
import 'package:todo_app_comp/widgets/date_picker.dart';
import 'package:todo_app_comp/list_element.dart';
import 'package:todo_app_comp/models/task.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({
    super.key,
  });
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    taskController.filteredTaskList = taskController.taskList;
  }

  @override
  Widget build(BuildContext context) {
    void runFilter(String enterKeyword) {
      List<Task> result = [];

      if (enterKeyword.isEmpty) {
        result = taskController.taskList;
      } else {
        result = taskController.taskList
            .where((item) => item.taskName
                .toLowerCase()
                .contains(enterKeyword.toLowerCase()))
            .toList();
      }
      taskController.filteredTaskList.value = result;
      taskController.filteredTaskList.sort((a, b) => a.date.compareTo(b.date));
    }

    void runFilterWithDate(DateTime selectedDate) {
      List<Task> result = [];
      result = taskController.taskList.where((item) {
        return item.date.year == selectedDate.year &&
            item.date.month == selectedDate.month &&
            item.date.day == selectedDate.day;
      }).toList();
      taskController.filteredTaskList.value = result;
      taskController.filteredTaskList.sort((a, b) => a.date.compareTo(b.date));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              DatePicker(
                runFilterWithDate: (selectedDate) =>
                    runFilterWithDate(selectedDate),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onChanged: (value) => runFilter(value),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      prefixIcon: const Icon(Icons.search, color: myBlack),
                      hintText: "Search",
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: taskController.taskList.isNotEmpty
                        ? taskController.taskList.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListElement(
                          task:taskController.taskList[index], taskController: taskController,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
