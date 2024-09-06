import 'package:flutter/material.dart';

enum Priority {
  urgent(color: Colors.red, title: "Urgent"),
  high(color: Colors.orange, title: "High"),
  medium(color: Colors.yellow, title: "Medium"),
  low(color: Colors.pink, title: "Low");

  const Priority({required this.color, required this.title});
  final Color color;
  final String title;
  String toJson() => title;
  static Priority fromJson(String json) {
    switch (json) {
      case "Urgent":
        return Priority.urgent;
      case "High":
        return Priority.high;
      case "Medium":
        return Priority.medium;
      case "Low":
        return Priority.low;
      default:
        throw ArgumentError("Unknown priority: $json");
    }
  }
}
