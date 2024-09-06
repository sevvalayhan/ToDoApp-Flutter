import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app_comp/add_task.dart';
import 'package:todo_app_comp/controllers/home_page_controller.dart';
import 'package:todo_app_comp/controllers/task_controller.dart';
import 'package:todo_app_comp/task_list_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var taskController = Get.put(TaskController());
  var homePageController = Get.put(HomePageController()); 
  late final List<Widget> _screens = [const TaskListPage(), const AddTask()];
 

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    taskController.fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            title: const SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, size: 30),
                  Text("To Do App",
                      style: TextStyle(fontSize: 40, fontFamily: 'Huglove')),
                ],
              ),
            ),
          ),
        ),
        body: Obx(() => Column(
              children: [
                Expanded(
                  child: _screens[homePageController.currentIndex.value],
                ),
              ],
            )),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            onDestinationSelected: (int index) async {
              if (index == 1) {
                Get.toNamed('/addTask')?.then((newTask) {
                  if (newTask != null) {
                    taskController.addTask(newTask);
                  } else {
                    homePageController.currentIndex.value = index;
                  }
                });
              } else {
                homePageController.currentIndex.value = index;
              }
            },
            selectedIndex: homePageController.currentIndex.value,
            destinations: const [
              NavigationDestination(
                icon: Icon(Iconsax.home),
                selectedIcon: Icon(Iconsax.home_2),
                label: "Tasks",
              ),
              NavigationDestination(
                icon: Icon(Iconsax.element_plus),
                selectedIcon: Icon(Icons.plus_one_outlined),
                label: "Add Task",
              ),
            ],
          ),
        ));
  }
}
