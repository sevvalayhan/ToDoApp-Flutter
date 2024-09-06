import 'package:flutter/material.dart';

class PercentPadding extends StatelessWidget {
  const PercentPadding({super.key, required this.child, required this.padding});

  final Widget child;
  final EdgeInsetsGeometry padding;

  static EdgeInsetsGeometry all(BuildContext context,
      {required double value, bool accordingToHeight = false}) {
    double p;
    if (accordingToHeight) {
      p = MediaQuery.of(context).size.height * (value / 100);
    } else {
      p = MediaQuery.of(context).size.width * (value / 100);
    }

    return EdgeInsets.all(p);
  }

  static double toPercent(BuildContext context,
      {required double value, bool accordingToHeight = false}) {
    double p;
    if (accordingToHeight) {
      p = MediaQuery.of(context).size.height * (value / 100);
    } else {
      p = MediaQuery.of(context).size.width * (value / 100);
    }

    return p;
  }

  static EdgeInsetsGeometry only(BuildContext context,
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;

    return EdgeInsets.only(
        left: left * w, right: right * w, top: top * h, bottom: bottom * h);
  }

  static EdgeInsetsGeometry symmetric(BuildContext context,
      {double horizontal = 0, double vertical = 0}) {
    double w = MediaQuery.of(context).size.width / 100;

    double h = MediaQuery.of(context).size.height / 100;

    return EdgeInsets.symmetric(
        vertical: vertical * h, horizontal: horizontal * w);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}