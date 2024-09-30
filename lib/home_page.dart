import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todo_app_comp/add_task.dart';
import 'package:todo_app_comp/constants/my_title_text.dart';
import 'package:todo_app_comp/controllers/task_controller.dart';
import 'package:todo_app_comp/models/task.dart';
import 'package:todo_app_comp/task_list_page.dart';
import 'package:todo_app_comp/widgets/home_page_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool detailIsVisible = true;
  var taskController = Get.put(TaskController());
  late final List<Widget> _screens = [
    TaskListPage(
      isDetailsVisible: detailIsVisible,
    ),
    const AddTask(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            centerTitle: true,
            title: SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(""),
                    const MyTitleText(title: "My ToDo App"),
                    IconButton(
                        onPressed: () {},
                        icon: const CircleAvatar(
                            backgroundImage: AssetImage(
                          "assets/images/user.jpg",
                        ))),
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: const HomePageDrawer(),
        body: Column(
          children: [
            Expanded(
              child: _screens[currentIndex],
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) async {
            if (index == 2) {
              filterIsComplated(taskController);
            } else if (index == 1) {
              Get.toNamed('/addTask');
            } else {
              currentIndex = index;
            }
          },
          selectedIndex: currentIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              selectedIcon: Icon(Iconsax.home_2),
              label: "Yapılacaklar",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.element_plus),
              selectedIcon: Icon(Icons.plus_one_outlined),
              label: "Ekle",
            ),
            NavigationDestination(
                icon: Icon(Icons.checklist_rtl), label: "Tamamlananlar")
          ],
        ));
  }

  void filterIsComplated(TaskController taskController) {
    List<Task> result =
        taskController.tasks.where((task) => task.isCompleted == true).toList();
    taskController.filteredTaskList.value = result;
    taskController.filteredTaskList.sort((a, b) => a.date.compareTo(b.date));
  }
}
