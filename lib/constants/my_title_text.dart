import 'package:flutter/material.dart';

class MyTitleText extends StatefulWidget {
  const MyTitleText({super.key, required this.title});
  final String title;

  @override
  State<MyTitleText> createState() => _MyTitleTextState();
}

class _MyTitleTextState extends State<MyTitleText> {
  @override
  Widget build(BuildContext context) {
    return   Text(widget.title,style: const TextStyle(fontFamily: 'Huglove',fontSize: 25),);
  }
}