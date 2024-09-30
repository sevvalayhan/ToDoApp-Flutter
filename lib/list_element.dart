import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_comp/constants/colors.dart';
import 'package:todo_app_comp/controllers/task_controller.dart';
import 'package:todo_app_comp/models/task.dart';

// ignore: must_be_immutable
class ListElement extends StatelessWidget {
  ListElement(
      {super.key,
      required this.task,
      required this.taskController,
      required this.index,
      required this.isDetailsVisible});

  final Task task;
  final int index;
  final TaskController taskController;
  bool isDetailsVisible;

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('yMMMMd', 'tr_TR').format(task.date);
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
                    title: "Silmek istediğinize emin misiniz?",
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
                        onPressed: () async {
                          if (await taskController.deleteTask(task.id)) {
                            Get.back();
                            taskController.getTasks();
                          }
                        },
                        child: const Text("Delete"),
                      ),
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
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return TaskDetailCard(
              //         titleText: task.taskName,
              //         detailText: task.taskDescription,
              //         date: date.toString(),
              //       );
              //     });
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
              onChanged: (bool? value) async {
                await taskController.changeCheckBox(
                    task.id); //burası düzeldi sanki, bir çalıştırayım mı
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
                      Text(
                        task.taskName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration:
                              taskController.filteredTaskList[index].isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
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
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      date.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Get.toNamed("/updateTask",
                            arguments: {"taskId": task.id});
                        print("TASK ID: " + task.id.toString());
                      },
                      icon: const Icon(Icons.settings, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
