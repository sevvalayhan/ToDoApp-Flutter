import 'package:flutter/material.dart';
import 'package:todo_app_comp/constants/colors.dart';

// ignore: must_be_immutable
class MyTextformField extends StatefulWidget {
  MyTextformField(
      {super.key,
      this.hintText,
      required this.labelText,
      this.valueLenght,
      required this.maxLength,
      this.onChanged, this.validator, this.controller, });
  final String labelText;
  int? valueLenght;
  final int maxLength;
  String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FormFieldValidator? validator;



  @override
  State<MyTextformField> createState() => _MyTextformFieldState();
}

class _MyTextformFieldState extends State<MyTextformField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: myLila,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1.5, color: myBlack),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 2.0),
          ),
        ),
        style: const TextStyle(fontSize: 16.0),
        keyboardType: TextInputType.text,
        validator: widget.validator,
        controller: widget.controller,
      ),
    );
  }
}
