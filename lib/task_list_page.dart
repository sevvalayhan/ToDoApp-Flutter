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
    required this.isDetailsVisible,
  });

  final bool isDetailsVisible;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              MyDatePicker(
                taskController: taskController,
              ),
              const SizedBox(height: 5),
              CustomSearchBox(
                taskController: taskController,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        taskController.filteredTaskList.value =
                            taskController.tasks;
                        taskController.filteredTaskList.sort((a,b)=>a.date.compareTo(b.date));
                      },
                      icon: const Icon(Icons.menu_rounded))
                ],
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: taskController.filteredTaskList.isNotEmpty
                        ? taskController.filteredTaskList.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      print("Filteredtasklist:---------------- " +
                          taskController.filteredTaskList.length.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListElement(
                          index: index,
                          task: taskController.filteredTaskList[index],
                          taskController: taskController,
                          isDetailsVisible: widget.isDetailsVisible,
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

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({
    super.key,
    required this.taskController,
  });
  final TaskController taskController;
  void runFilter(String enterKeyword) {
    List<Task> result = [];

    if (enterKeyword.isEmpty) {
      result = taskController.tasks;
    } else {
      result = taskController.tasks
          .where((item) =>
              item.taskName.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }
    taskController.filteredTaskList.value = result;
    taskController.filteredTaskList.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            prefixIcon: const Icon(Icons.search, color: myBlack),
            hintText: "Search",
            border:
                UnderlineInputBorder(borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({
    super.key,
    required this.taskController,
  });
  final TaskController taskController;
  void runFilterWithDate(DateTime selectedDate) {
    List<Task> result = [];
    result = taskController.tasks.where((item) {
      return item.date.year == selectedDate.year &&
          item.date.month == selectedDate.month &&
          item.date.day == selectedDate.day;
    }).toList();
    taskController.filteredTaskList.value = result;
    taskController.filteredTaskList.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      runFilterWithDate: (selectedDate) => runFilterWithDate(selectedDate),
    );
  }
}
