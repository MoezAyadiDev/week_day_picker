import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/week_day_picker.dart';

class WeekDayState {
  final DateTime? selectedDate;
  final int year;
  final MonthModel month;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<int> years;
  final List<MonthModel> months;
  final List<DayModel> days;
  final bool isLastWeek;
  final bool isFirstWeek;
  final List<DateTime>? selectableDay;
  final List<int>? selectableDayInWeek;
  final BitwiseOperator selectableBitwiseOperator;
  final DateTime toDayDate;

  WeekDayState({
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.year,
    required this.month,
    required this.years,
    required this.months,
    required this.days,
    required this.toDayDate,
    bool? isLastWeek,
    bool? isFirstWeek,
    this.selectableDay,
    this.selectableDayInWeek,
    this.selectableBitwiseOperator = BitwiseOperator.and,
  })  : isFirstWeek = isFirstWeek ?? firstWeekCheek(days, firstDate),
        isLastWeek = isLastWeek ?? lastWeekCheek(days, lastDate);

  WeekDayState copyWith({
    DateTime? selectedDate,
    int? year,
    MonthModel? month,
    List<MonthModel>? months,
    List<DayModel>? days,
  }) {
    return WeekDayState(
      selectedDate: selectedDate ?? this.selectedDate,
      year: year ?? this.year,
      month: month ?? this.month,
      firstDate: firstDate,
      lastDate: lastDate,
      years: years,
      months: months ?? this.months,
      days: days ?? this.days,
      isFirstWeek: firstWeekCheek(days ?? this.days, firstDate),
      isLastWeek: lastWeekCheek(days ?? this.days, lastDate),
      toDayDate: toDayDate,
      selectableDay: selectableDay,
      selectableDayInWeek: selectableDayInWeek,
      selectableBitwiseOperator: selectableBitwiseOperator,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekDayState &&
          runtimeType == other.runtimeType &&
          selectedDate == other.selectedDate &&
          year == other.year &&
          month == other.month &&
          firstDate == other.firstDate &&
          years == other.years &&
          months == other.months &&
          days == other.days &&
          lastDate == other.lastDate &&
          isFirstWeek == other.isFirstWeek &&
          isLastWeek == other.isLastWeek &&
          toDayDate == other.toDayDate &&
          selectableDay == other.selectableDay &&
          selectableDayInWeek == other.selectableDayInWeek &&
          selectableBitwiseOperator == other.selectableBitwiseOperator;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        selectedDate,
        year,
        month,
        firstDate,
        lastDate,
        years,
        months,
        days,
        isFirstWeek,
        isLastWeek,
        toDayDate,
        selectableDay,
        selectableDayInWeek,
        selectableBitwiseOperator,
      );

  @override
  String toString() {
    String toString = 'WeekDayState:(\n date:$selectedDate, \n year:$year, ';
    toString += '\n month:$month, \n firstDate:$firstDate, ';
    toString += '\n lastDate:$lastDate,';
    toString += '\n years:$years, \n months:$months, \n days:$days,';
    toString += '\n toDayDate:$toDayDate, ';
    toString += '\n selectableDay:$selectableDay, ';
    toString += '\n selectableDayInWeek:$selectableDayInWeek,';
    toString += '\n selectableBitwiseOperator:$selectableBitwiseOperator, \n)';
    return toString;
  }
}
