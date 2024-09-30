import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDetailCard extends StatelessWidget {
  const TaskDetailCard({
    super.key,
    required this.titleText,
    required this.detailText,
    required this.date,
  });
  final String titleText;
  final String detailText;
  final String date;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:  Center(
        child: Padding(
          
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
          child: Container(color: Colors.pink,child: Stack(children: [Row(mainAxisAlignment: MainAxisAlignment.end,children: [IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.one_x_mobiledata))],)],)) ,),
      ),
      );  
  }
}