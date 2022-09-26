import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/state/app_scope.dart';
import 'package:week_day_picker/src/state/week_day_state.dart';
import 'package:week_day_picker/src/week_day_picker.dart';

class WeekDayWidget extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<DateTime>? selectableDay;
  final List<int>? selectableDayInWeek;
  final BitwiseOperator selectableBitwiseOperator;
  final Widget child;

  const WeekDayWidget({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.child,
    required this.selectableDay,
    required this.selectableDayInWeek,
    required this.selectableBitwiseOperator,
  });

  @override
  State<WeekDayWidget> createState() => WeekDayWidgetState();

  static WeekDayWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<WeekDayWidgetState>()!;
  }
}

class WeekDayWidgetState extends State<WeekDayWidget> {
  late WeekDayState appState;
  final log = Logger('WeekDayWidget');

  @override
  void initState() {
    super.initState();
    log.fine('init Sate');
    DateTime selectedDate = widget.initialDate ?? dateOnly(DateTime.now());
    List<int> years = getYear(widget.firstDate, widget.lastDate);

    List<MonthModel> months = getMonth(
      widget.firstDate,
      widget.lastDate,
      widget.initialDate ?? DateTime.now(),
    );

    final days = getDay(
      selectedDate,
      widget.firstDate,
      widget.lastDate,
      widget.selectableDay,
      widget.selectableDayInWeek,
      widget.selectableBitwiseOperator,
    );

    appState = WeekDayState(
      selectedDate: widget.initialDate,
      lastDate: widget.lastDate,
      firstDate: widget.firstDate,
      year: selectedDate.year,
      month: MonthModel(
        month: DateFormat("MMMM").format(selectedDate).capitalize(),
        count: selectedDate.month,
      ),
      years: years,
      months: months,
      days: days,
      selectableDay: widget.selectableDay,
      selectableDayInWeek: widget.selectableDayInWeek,
      selectableBitwiseOperator: widget.selectableBitwiseOperator,
      toDayDate: selectedDate,
    );
    //print(appState);
  }

  ///Select new date from item list
  ///
  ///
  setSelectedDate(DateTime selectedDate) {
    log.fine('setSelectedDate');
    setState(() {
      appState = appState.copyWith(selectedDate: selectedDate);
    });
  }

  ///Select new month from month list
  ///
  ///
  setMouths(MonthModel month) {
    log.fine('setMouths');
    DateTime newDate = DateTime(
      appState.year,
      month.count,
      appState.days[0].day.day,
    );
    final days = getDay(
      newDate,
      appState.firstDate,
      appState.lastDate,
      appState.selectableDay,
      appState.selectableDayInWeek,
      appState.selectableBitwiseOperator,
    );
    setState(() {
      appState = appState.copyWith(month: month, days: days);
    });
  }

  ///Select new year from year list
  ///
  ///
  setYear(int year) {
    log.fine('setYear');
    DateTime newDate = DateTime(
      year,
      appState.month.count,
      appState.days[0].day.day,
    );
    if (newDate.isAfter(widget.lastDate)) {
      newDate = widget.lastDate;
    }
    if (newDate.isBefore(widget.firstDate)) {
      newDate = widget.firstDate;
    }
    final days = getDay(
      newDate,
      appState.firstDate,
      appState.lastDate,
      appState.selectableDay,
      appState.selectableDayInWeek,
      appState.selectableBitwiseOperator,
    );
    List<MonthModel> months = getMonth(
      widget.firstDate,
      widget.lastDate,
      newDate,
    );
    setState(() {
      appState = appState.copyWith(
        year: year,
        days: days,
        months: months,
        month: months.firstWhere(
          (element) => element.count == days.first.day.month,
          orElse: () => months.first,
        ),
      );
    });
  }

  previousWeek() {
    log.fine('previousWeek');
    DateTime previousDayByWeek =
        appState.days[0].day.add(const Duration(days: -7));

    final newDays = getDay(
      previousDayByWeek,
      appState.firstDate,
      appState.lastDate,
      appState.selectableDay,
      appState.selectableDayInWeek,
      appState.selectableBitwiseOperator,
    );

    MonthModel? month = checkMonth(newDays[0].day.month, false);
    int? year = checkYear(newDays[0].day.year, false);

    setState(() {
      appState = appState.copyWith(
        days: newDays,
        month: month,
        year: year,
      );
    });
  }

  nextWeek() {
    log.fine('nextWeek');
    DateTime nextDayByWeek = appState.days[6].day.add(const Duration(days: 1));
    final newDays = getDay(
      nextDayByWeek,
      appState.firstDate,
      appState.lastDate,
      appState.selectableDay,
      appState.selectableDayInWeek,
      appState.selectableBitwiseOperator,
    );

    MonthModel? month = checkMonth(newDays[0].day.month, true);
    int? year = checkYear(newDays[0].day.year, true);
    setState(() {
      appState = appState.copyWith(
        days: newDays,
        month: month,
        year: year,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    log.fine('build');
    return AppStateScope(data: appState, child: widget.child);
  }

  MonthModel? checkMonth(int newMonth, bool isNext) {
    log.fine('checkMonth');
    if (newMonth != appState.month.count) {
      return appState.months.firstWhere((element) => element.count == newMonth,
          orElse: () => isNext ? appState.months.last : appState.months.first);
    }
    return null;
  }

  int? checkYear(int newYear, bool isNext) {
    log.fine('checkYear');
    if (newYear != appState.year) {
      return appState.years.firstWhere((element) => element == newYear,
          orElse: () => isNext ? appState.years.last : appState.years.first);
    }
    return null;
  }
}
