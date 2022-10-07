import 'package:flutter/material.dart';
import 'package:week_day_picker/src/states/color_provider.dart';
import 'package:week_day_picker/src/states/weekday_provider.dart';
import 'package:week_day_picker/src/states/weekday_state.dart';

///String Extension
///
///[capitalize] : Capitalize first character
extension StringExtension on String {
  ///String Extension
  ///
  ///[capitalize] : Capitalize first character
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

///BuildContext extension
///
///[appState] : replace AppStateScope.of(context) with context.appState
extension ContextHelper on BuildContext {
  ///BuildContext extension
  ///
  ///[appState] : replace AppStateScope.of(context) with context.appState
  WeekDayState get appState => WeekDayProvider.of(this);

  ///[color] : replace AppStateScope.of(context) with context.color
  ColorProvider get color => ColorProvider.of(this);
}

///DateTime extension
///
///[timeToZero] : set the time to 0
extension DateTimeExt on DateTime {
  ///DateTime extension
  ///
  ///[timeToZero] : set the time to 0
  DateTime get dateOnly {
    return DateUtils.dateOnly(DateTime(year, month, day));
  }

  //bool get isBeforeOrEquals
}
