import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.runFilterWithDate});
  final Function(DateTime)? runFilterWithDate;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
         
        ),
        padding: const EdgeInsets.all(8),
        child: EasyDateTimeLine(
          locale: "tr_TR",
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            widget.runFilterWithDate!(selectedDate);
          },
          activeColor: Colors.pink,
          headerProps: const EasyHeaderProps(
            
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
          ),
          dayProps: const EasyDayProps(
            
            activeDayStyle: DayStyle(
              borderRadius: 32.0, // Smaller border radius for active days
            ),
            inactiveDayStyle: DayStyle(
              borderRadius: 32.0, // Smaller border radius for inactive days
            ),
          ),
          timeLineProps: const EasyTimeLineProps(
            
            hPadding: 25.0, // Smaller padding from left and right
            separatorPadding: 25.0, // Smaller padding between days
          ),
        ));
  }
}
