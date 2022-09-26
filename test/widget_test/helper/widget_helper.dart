import 'package:flutter/material.dart';
import 'package:week_day_picker/week_day_picker.dart';

class MyWidgetTest extends StatelessWidget {
  const MyWidgetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                WeekDayPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022, 4),
                  lastDate: DateTime(2023, 4, 31),
                  selectableDayInWeek: [1, 5],
                ).show();
              },
              child: const Text('Week day picker'),
            ),
          ),
        ),
      ),
    );
  }
}
