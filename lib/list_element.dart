import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_comp/constants/colors.dart';
import 'package:todo_app_comp/controllers/task_controller.dart';
import 'package:todo_app_comp/models/task.dart';
import 'package:todo_app_comp/update_task.dart';

class ListElement extends StatefulWidget {
  ListElement({
    super.key,
    required this.index,
  });
  final int index;
  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  var taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Task task = taskController.taskList[widget.index];
      String taskDate = DateFormat.yMMMMd('tr_TR').format(task.date);
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Slidable(
          key: ValueKey(task.id),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Get.defaultDialog(
                      title: "Are you sure you want to delete this task?",
                      titlePadding: const EdgeInsets.all(20),
                      cancel: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Cancel")),
                      ),
                      content: const Text(""),
                      confirm: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              taskController.deleteTask(task);
                              Get.back();
                            },
                            child: const Text("Delete")),
                      ));
                },
                backgroundColor: Colors.white,
                foregroundColor: Colors.red.shade400,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(15),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: task.priority.color.withOpacity(0.8),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: task.priority.color.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              onTap: () async {
                // await Get.to(UpdateTask(task: taskController.task.value))
                //     ?.then((task) {
                //   if (task != null) {
                //     taskController.task = task;
                //   }
                // });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) {
                  taskController.changeCheckBox(widget.index);
                },
                checkColor: myBlack,
                activeColor: Colors.white,
                side: const BorderSide(color: myWhite),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            task.taskName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => Text(
                            task.taskDescription,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        taskDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Get.to(UpdateTask(task: task))?.then((_task) {
                            if (_task != null) {
                              task = _task;
                              taskController.updateTask(widget.index, task);
                            }
                          });
                        },
                        icon: const Icon(Icons.settings, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
