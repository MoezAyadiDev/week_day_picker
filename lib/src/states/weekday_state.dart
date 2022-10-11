import 'package:flutter/widgets.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/models/month_list.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/services/week_day_service.dart';

class WeekDayState {
  final WeekDayService _service;

  WeekDayState({
    required WeekDayService service,
    DateTime? initialDate,
  })  : _service = service,
        selectedDate = ValueNotifier(initialDate?.dateOnly),
        _years = service.getYears(),
        months = ValueNotifier(service.getMonths(initialDate?.dateOnly)),
        days = ValueNotifier(service.getDay(initialDate?.dateOnly)),
        year = ValueNotifier(service.firstYear(initialDate?.dateOnly)) {
    isLast = ValueNotifier(_service.isLastWeek(days.value[0].day));
    isFirst = ValueNotifier(_service.isFirstWeek(days.value[0].day));
  }

  // var log = Logger('WeekDayState');

  //SELECTED DATE BLOC
  ValueNotifier<DateTime?> selectedDate;

  selectedDateChanged(DateTime newSelectedDate) {
    // log.finest('selectedDateChanged');
    selectedDate.value = newSelectedDate;
  }

  //DAYS DATE BLOC
  ValueNotifier<List<DayModel>> days;

  //MONTH DATE BLOC
  ValueNotifier<MonthList> months;
  selectedMonthChanged(MonthModel newMonth) {
    // log.finest('selectedMonthChanged');
    if (newMonth == months.value.month) {
      return;
    }
    //Get new date
    DateTime newDate = _service.getDateYearChanged(
      year.value,
      newMonth.count,
      days.value[0].day.day,
    );
    if (newDate.month < newMonth.count) {
      newDate = newDate.add(const Duration(days: 7));
    }
    //Get month
    var newMonths = _service.getMonths(newDate);
    if (newMonths != months.value) {
      months.value = newMonths;
    }
    var newDays = _service.getDay(newDate);
    if (newDays != days.value) {
      days.value = newDays;
    }
    isLast.value = _service.isLastWeek(days.value[0].day);
    isFirst.value = _service.isFirstWeek(days.value[0].day);
  }

  //YEAR DATE BLOC
  ValueNotifier<int> year;
  selectedYearChanged(int newYear) {
    // log.fine('selectedYearChanged $newYear');
    if (newYear == year.value) {
      return;
    }
    year.value = newYear;
    //Get new date
    DateTime newDate = _service.getDateYearChanged(
      newYear,
      months.value.month.count,
      days.value[0].day.day,
    );

    //Get month
    var newMonths = _service.getMonths(newDate);
    if (newMonths != months.value) {
      months.value = newMonths;
    }

    var newDays = _service.getDay(newDate);
    if (newDays != days.value) {
      days.value = newDays;
    }
    isLast.value = _service.isLastWeek(days.value[0].day);
    isFirst.value = _service.isFirstWeek(days.value[0].day);
  }

  late final List<int> _years;
  List<int> get years => _years;

  //ISLAST ISFIRST BLOC
  late ValueNotifier<bool> isLast;
  //ValueNotifier(_service.isLastWeek(days.value[6].day));

  late ValueNotifier<bool> isFirst;
  //   ValueNotifier(_service.isFirstWeek(days.value[0].day));

  nextWeek() {
    // log.finest('nextWeek : ${isLast.value}');
    if (!isLast.value) {
      DateTime newDate = _service.getNextWeek(days.value[0].day);
      // log.fine('newDate : $newDate');
      if (year.value != newDate.year) {
        year.value = newDate.year;
      }
      if (months.value.month.count != newDate.month) {
        var newMonths = _service.getMonths(newDate);
        if (newMonths != months.value) {
          months.value = newMonths;
        }
      }
      var newDays = _service.getDay(newDate);
      if (newDays != days.value) {
        days.value = newDays;
      }
      isLast.value = _service.isLastWeek(days.value[0].day);
      isFirst.value = _service.isFirstWeek(days.value[0].day);
    }
    // log.finest('nextWeek final : ${isLast.value}');
  }

  previousWeek() {
    // log.finest('previousWeek : ${isFirst.value}');
    if (!isFirst.value) {
      DateTime newDate = _service.getLastWeek(days.value[0].day);
      // log.fine('newDate : $newDate');
      if (year.value != newDate.year) {
        year.value = newDate.year;
      }
      if (months.value.month.count != newDate.month) {
        var newMonths = _service.getMonths(newDate);
        if (newMonths != months.value) {
          months.value = newMonths;
        }
      }
      var newDays = _service.getDay(newDate);
      if (newDays != days.value) {
        days.value = newDays;
      }
      isLast.value = _service.isLastWeek(days.value[0].day);
      isFirst.value = _service.isFirstWeek(days.value[0].day);
    }
    // log.finest('previousWeek final : ${isFirst.value} ${days.value[0]}');
  }

  DateTime get currentdate => _service.currentdate;
}
