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

class UpdateTask extends StatefulWidget {
  UpdateTask({super.key});
  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final _formGlobalKey = GlobalKey<FormState>();
  var taskController = Get.put(TaskController());
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Task thisTask;
  @override
  void initState() {
    super.initState();
    int taskId = Get.arguments["taskId"];
    thisTask =
        taskController.filteredTaskList.firstWhere((task) => task.id == taskId);
    print(thisTask.toJson());
    _titleController = TextEditingController(text: thisTask.taskName);
    _descriptionController =
        TextEditingController(text: thisTask.taskDescription);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != thisTask.date) {
      thisTask.date = picked;
    }
  }

  void submitTask() async {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState!.save();
      print(thisTask.toJson());
      if (await taskController.updateTask(thisTask.id, thisTask)) {
        Get.snackbar("Başarılı", "Veriler kaydedildi",
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            padding: const EdgeInsets.all(8.0),
            icon: const Icon(
              Iconsax.tick_circle,
              color: Colors.green,
            ),
            backgroundColor: Colors.green.shade100);
        Get.toNamed('/homePage');
      } else {
        Get.snackbar("Hata", "Güncellemeler kaydedilemedi");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myLila,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const MyTitleText(title: "Hedefinizi Güncelleyin"),
                      const SizedBox(height: 20),
                      MyTextformField(
                          labelText: "Başlık",
                          maxLength: 10,//bir dakika
                          onChanged: (value) {
                            thisTask.taskName = value;
                          },
                          validator: (value) {
                          if (value.length < 5) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                          controller: _titleController),
                      const SizedBox(height: 20),
                      MyTextformField(
                        labelText: "Açıklama",
                        maxLength: 50,
                        onChanged: (value) {
                          thisTask.taskDescription = value;
                        },
                        controller: _descriptionController,
                       validator: (value) {
                          if (value.length < 5) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<Priority>(
                        value: thisTask.priority,
                        onChanged: (value) {
                          setState(() {
                            thisTask.priority = value!;
                          });
                        }, //hoşgeldinn:)
                        decoration: InputDecoration(
                          label: const Text("Öncelik"),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: myBlack, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: thisTask.priority.color, width: 2),
                          ),
                        ),
                        items: Priority.values.map((p) {
                          return DropdownMenuItem(
                            value: p,
                            child: Text(p.title),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(thisTask.date == null
                              ? 'Tarih seçilmedi'
                              : ' ${DateFormat.yMMMMd('tr_TR').format(thisTask.date)}'),
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
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Vazgeç")),
                      ElevatedButton(
                        onPressed: () {
                          submitTask();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Güncelle"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
