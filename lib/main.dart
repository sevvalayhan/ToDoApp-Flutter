import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app_comp/add_task.dart';
import 'package:todo_app_comp/home_page.dart';

void main() async{
 await GetStorage.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(       
      ),
      home:  const MyHomePage(),
      getPages: [
        GetPage(name: "/homePage", page:()=> const MyHomePage()),
        GetPage(name: "/addTask", page: ()=>const AddTask()),
      ],
      routes: {
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}