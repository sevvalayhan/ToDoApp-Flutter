import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class ClendarDatePickerView extends StatefulWidget {
  const ClendarDatePickerView({super.key});

  @override
  State<ClendarDatePickerView> createState() => _ClendarDatePickerViewState();
}

class _ClendarDatePickerViewState extends State<ClendarDatePickerView> {
  List<DateTime?> _dates = [DateTime(2024,04,19),DateTime(2024,04,20)];
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2WithActionButtons(
      config: CalendarDatePicker2WithActionButtonsConfig(
        firstDayOfWeek: 1,
        calendarType: CalendarDatePicker2Type.range,
        selectedDayTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        selectedDayHighlightColor: Colors.purple[800],
        centerAlignModePicker: true,
        customModePickerIcon: const SizedBox(),
      ),
      value: _dates,
      onValueChanged: (dates) => _dates = dates,
    );
  }
}
