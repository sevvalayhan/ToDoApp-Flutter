import 'package:flutter/material.dart';

enum Priority {
  urgent(color: Color.fromARGB(255, 218, 16, 16), title: "Acil"),
  high(color: Color.fromRGBO(207, 0, 248, 0.69), title: "Yüksek"),
  medium(color: Color.fromARGB(167, 47, 218, 67), title: "Orta"),
  low(color: Color.fromARGB(255, 217, 72, 120), title: "Düşük");

  const Priority({required this.color, required this.title});
  final Color color;
  final String title;
  String toJson() =>name.toString();
  static Priority fromJson(String json) {
    switch (json) {
      case "urgent":
        return Priority.urgent;
      case "high":
        return Priority.high;
      case "medium":
        return Priority.medium;
      case "low":
        return Priority.low;
      default:
        throw ArgumentError("Unknown priority: $json");
    }
  }
}
