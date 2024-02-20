import 'package:flutter/widgets.dart';

import 'weekday_state.dart';

class WeekDayProvider extends InheritedWidget {
  final WeekDayState weekDayState;

  const WeekDayProvider({
    super.key,
    required super.child,
    required this.weekDayState,
  });

  static WeekDayState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<WeekDayProvider>()!
      .weekDayState;

  @override
  bool updateShouldNotify(WeekDayProvider oldWidget) => false;
}
