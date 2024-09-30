import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_comp/constants/colors.dart';
import 'package:todo_app_comp/constants/my_textform_field.dart';
import 'package:todo_app_comp/constants/my_title_text.dart';

import 'package:todo_app_comp/controllers/task_controller.dart';
import 'package:todo_app_comp/models/task.dart';
import 'package:todo_app_comp/priority.dart';
import 'package:todo_app_comp/widgets/home_page_drawer.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formglobalKey = GlobalKey<FormState>();
  final taskController = Get.put(TaskController());

  String taskName = '';
  String taskDescription = '';
  bool isCompleted = false;
  Priority? priority = Priority.low;
  DateTime? date;

  void _submitTask() async {
    if (_formglobalKey.currentState!.validate()) {
      _formglobalKey.currentState!.save();

      Task newTask = Task(
          id: DateTime.now().microsecondsSinceEpoch,
          taskName: taskName,
          taskDescription: taskDescription,
          isCompleted: isCompleted,
          priority: priority!,
          date: date!);

      if (await taskController.addTask(newTask)) {
        Get.toNamed('/homePage');
        Get.snackbar("Başarılı", "Veriler kaydedildi",
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            padding: const EdgeInsets.all(8.0),
            icon: const Icon(
              Iconsax.tick_circle,
              color: Colors.green,
            ),
            backgroundColor: Colors.green.shade100);
      } else {
        Get.snackbar("Hata", "Veriler kaydedilirken bir sorun oluştu.",
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            padding: const EdgeInsets.all(8.0),
            icon: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            backgroundColor: Colors.red.shade100);
      }
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myLila,
      ),
      drawer: const HomePageDrawer(),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
        child: Form(
          key: _formglobalKey,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const MyTitleText(title: "o  Yeni Bir Hedef Ekleyin  o"),
                      const SizedBox(height: 20),
                      MyTextformField(
                        labelText: "Başlık",
                        valueLenght: 5,
                        maxLength: 10,
                        onChanged: (value) {
                          taskName = value;
                        },
                        validator: (value) {
                          if (value.length < taskName.length) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextformField(
                        labelText: "Açıklama",
                        valueLenght: 5,
                        maxLength: 50,
                        onChanged: (value) {
                          taskDescription = value;
                        },
                        validator: (value) {
                          if (value.length < taskDescription.length) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<Priority>(
                        value: priority,
                        decoration: InputDecoration(
                          label: const Text("Öncelik"),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: myBlack, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: priority!.color, width: 2),
                          ),
                        ),
                        items: Priority.values.map((p) {
                          return DropdownMenuItem(
                            value: p,
                            child: Text(p.title),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            priority = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(date == null
                              ? 'Tarih seçilmedi'
                              : ' ${DateFormat.yMMMMd('tr_TR').format(date!)}'),
                          ElevatedButton(
                            onPressed: () {
                              selectDate(context);
                            },
                            child: const Text('Tarih Seç'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Center(
                  child: FilledButton(
                    onPressed: () {
                      _submitTask();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Ekle"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
