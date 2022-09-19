import 'package:flutter/material.dart';
import 'package:week_day_picker/src/helpers/day_helper.dart';
import 'package:week_day_picker/src/widgets/item_widget.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

class WeekDayPicker {
  ///The application context
  final BuildContext context;

  WeekDayPicker({required this.context});

  ///Display the weekDayWidget
  ///
  show() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        //title: Text('WeekDayPricer'),
        children: getDay()
            .map(
              (day) => buildItem(day),
            )
            .toList(),
      ),
    );
  }
}
