import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_comp/constants/colors.dart';
import 'package:todo_app_comp/controllers/task_controller.dart';
import 'package:todo_app_comp/models/task.dart';
import 'package:todo_app_comp/priority.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formGlobalKey = GlobalKey<FormState>();
  final taskController = Get.find<TaskController>();

  void _submitTask() {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState!.save();
      Task newTask = Task(
          id: DateTime.now().microsecondsSinceEpoch,
          taskName: taskController.task.value.taskName,
          taskDescription: taskController.task.value.taskDescription,
          isCompleted: false,
          priority: taskController.task.value.priority,
          date: taskController.task.value.date);

      taskController.addTask(newTask);
      Get.back(result: newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != taskController.task.value.date) {
        taskController.task.value.date = picked;
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: myLila,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.menu, size: 30, color: myBlack),
              SizedBox(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formGlobalKey,
              child: Column(children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            maxLength: 10,
                            decoration: const InputDecoration(
                              label: Text("ToDo Title"),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return "En az 3 karakter girin";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              taskController.task.update((task)
                              {
                                task?.taskName = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("ToDo Description"),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 5) {
                                return "En az 5 karakter girin";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              taskController.task.update((task)
                              {
                                task?.taskDescription=value;
                              });
                            },
                          ),
                          Obx(
                            ()=> DropdownButtonFormField<Priority>(
                              value: taskController.task.value.priority,
                              decoration: InputDecoration(
                                label: const Text("Priority"),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: taskController.task.value.priority.color, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: taskController.task.value.priority.color, width: 2),
                                ),
                              ),
                              items: Priority.values.map((p) {
                                return DropdownMenuItem(
                                  value: p,
                                  child: Text(p.title),
                                );
                              }).toList(),
                              onChanged: (value) {
                                taskController.task.value.priority = value!;
                              },
                            ),
                          ),
                          Obx(
                            ()=> Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // ignore: unnecessary_null_comparison
                                  Text(taskController.task.value.date == null
                                      ? 'Tarih seçilmedi'
                                      : ' ${DateFormat.yMMMMd('tr_TR').format(taskController.task.value.date)}'),
                                  const SizedBox(
                                    height: 20,
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () => selectDate(context),
                                    child: const Text('Tarih Seç'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      FilledButton(
                        onPressed: () {
                          _submitTask();
                          Get.snackbar("Başarılı", "Veriler kaydedildi",
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20),
                              padding: const EdgeInsets.all(8.0),
                              icon: const Icon(
                                Iconsax.tick_circle,
                                color: Colors.green,
                              ),
                              backgroundColor: Colors.green.shade100);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Ekle"),
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
