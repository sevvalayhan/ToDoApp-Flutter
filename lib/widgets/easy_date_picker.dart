import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class EasyDatePickers extends StatefulWidget {
  const EasyDatePickers({super.key});

  @override
  State<EasyDatePickers> createState() => _EasyDatePickersState();
}

class _EasyDatePickersState extends State<EasyDatePickers> {
  @override
  Widget build(BuildContext context) {
    return EasyInfiniteDateTimeLine(
      selectionMode: const SelectionMode.autoCenter(),
      firstDate: DateTime(2024),
      focusDate: DateTime.now(),
      lastDate: DateTime(2024, 12, 31),
      onDateChange: (selectedDate) {
        setState(() {});
      },
      dayProps: const EasyDayProps(
        // You must specify the width in this case.
        width: 64.0,
        // The height is not required in this case.
        height: 64.0,
      ),
      itemBuilder: (
        BuildContext context,
        DateTime date,
        bool isSelected,
        VoidCallback onTap,
      ) {
        return InkResponse(
          onTap: onTap,
          child: CircleAvatar(
            // use `isSelected` to specify whether the widget is selected or not.
            backgroundColor:
                isSelected ? Colors.pink : Colors.pink.withOpacity(0.1),
            radius: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    EasyDateFormatter.shortDayName(date, "tr_TR"),
                    style: TextStyle(
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
