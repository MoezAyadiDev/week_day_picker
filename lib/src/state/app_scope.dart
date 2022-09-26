import 'package:flutter/material.dart';
import 'package:week_day_picker/src/state/week_day_state.dart';

class AppStateScope extends InheritedWidget {
  final WeekDayState data;

  const AppStateScope({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  static WeekDayState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;

  @override
  bool updateShouldNotify(AppStateScope oldWidget) => oldWidget.data != data;
}
