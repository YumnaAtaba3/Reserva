import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;
  final Color hourHandColor;
  final Color themeColor;
  final String time;

  CustomTimePicker({
    required this.initialTime,
    required this.onTimeSelected,
    this.hourHandColor = Colors.blue,
    this.themeColor = Colors.blue,
    required this.time,
  });

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: widget.themeColor, // Change the overall theme color
        ),
        timePickerTheme: TimePickerThemeData(
            hourMinuteColor: widget.hourHandColor,
            dayPeriodColor: Colors.blue[200],
            dialHandColor: Colors.blue[200] // Change the hour hand color
            ),
      ),
      child: Builder(
        builder: (context) {
          return Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                  widget.onTimeSelected(_selectedTime);
                }
              },
              child: Text(
                widget.time,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
