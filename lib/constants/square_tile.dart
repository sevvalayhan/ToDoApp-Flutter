import 'package:flutter/material.dart';

class SquareTile extends StatefulWidget {
  const SquareTile({super.key});
  

  @override
  State<SquareTile> createState() => _SquareTileState();
}

class _SquareTileState extends State<SquareTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: const Text("data"),
    );
  }
}
