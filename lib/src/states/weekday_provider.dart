import 'package:flutter/widgets.dart';

import 'weekday_state.dart';

class WeekDayProvider extends InheritedWidget {
  final WeekDayState weekDayState;

  const WeekDayProvider({
    Key? key,
    required Widget child,
    required this.weekDayState,
  }) : super(
          key: key,
          child: child,
        );

  static WeekDayState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<WeekDayProvider>()!
      .weekDayState;

  @override
  bool updateShouldNotify(WeekDayProvider oldWidget) => false;
}
