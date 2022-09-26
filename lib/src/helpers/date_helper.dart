import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/week_day_picker.dart';

///Get the week day from given date
///
List<DayModel> getDay(
  DateTime initialdate,
  DateTime firstDay,
  DateTime lastDay,
  List<DateTime>? selectableDay,
  List<int>? selectableDayInWeek,
  BitwiseOperator bitwiseOperator,
) {
  List<DayModel> days = [];
  DateTime temp = initialdate;
  for (int i = 0; i < 7; i++) {
    //print('date to check $temp selectableDayInWeek = $selectableDayInWeek');
    days.add(
      DayModel(
        title: DateFormat("EEEE").format(temp).capitalize(),
        day: temp,
        isAllowed: isAllowedDay(
          temp,
          firstDay,
          lastDay,
          selectableDay,
          selectableDayInWeek,
          bitwiseOperator,
        ),
      ),
    );
    temp = temp.add(const Duration(days: 1));
  }
  return days;
}

///Get the list of year from first date and lastDate
///
List<int> getYear(DateTime firstDate, DateTime lastDate) {
  List<int> years = [];
  for (int i = firstDate.year; i <= lastDate.year; i++) {
    years.add(i);
  }
  return years;
}

///Get the list of year from first date and lastDate
///
List<MonthModel> getMonth(
  DateTime firstDate,
  DateTime lastDate,
  DateTime initialDate,
) {
  List<MonthModel> months = [];
  DateTime temp;
  //Begin Date for the year
  int dayBeginInYear;

  if (initialDate.year == firstDate.year) {
    dayBeginInYear = firstDate.month;
  } else {
    dayBeginInYear = 1;
  }
  //End Date for the year
  int dayEndInYear;
  if (initialDate.year == lastDate.year) {
    dayEndInYear = lastDate.month;
  } else {
    dayEndInYear = 12;
  }

  for (int i = dayBeginInYear; i <= dayEndInYear; i++) {
    temp = DateTime(firstDate.year, i);
    months.add(
      MonthModel(month: DateFormat("MMMM").format(temp).capitalize(), count: i),
    );
  }

  return months;
}

bool lastWeekCheek(List<DayModel> days, DateTime lastDate) {
  return days[6].day == lastDate ? true : days[6].day.isAfter(lastDate);
}

bool firstWeekCheek(List<DayModel> days, DateTime firstDate) {
  return days[0].day == firstDate ? true : days[0].day.isBefore(firstDate);
}

bool isAllowedDay(
  DateTime day,
  DateTime firstDay,
  DateTime lastDay,
  List<DateTime>? selectableDay,
  List<int>? selectableDayInWeek,
  BitwiseOperator bitwiseOperator,
) {
  if (day.isBefore(firstDay)) return false;
  if (day.isAfter(lastDay)) return false;
  if (selectableDay == null && selectableDayInWeek == null) {
    return true;
  } else {
    if (bitwiseOperator == BitwiseOperator.and) {
      if (selectableDay != null) {
        if (!selectableDay.any((element) => element == day)) {
          return false;
        }
      }
      if (selectableDayInWeek != null) {
        if (!selectableDayInWeek.any((element) => element == day.weekday)) {
          return false;
        }
      }
      return true;
    } else {
      if (selectableDay != null) {
        if (selectableDay.any((element) => element == day)) {
          return true;
        }
      }
      if (selectableDayInWeek != null) {
        if (selectableDayInWeek.any((element) => element == day.weekday)) {
          return true;
        }
      }
      return false;
    }
  }
}

DateTime dateOnly(DateTime date) {
  return date.dateOnly;
}

DateTime dateOnlyCompose(int year, int month, int day) {
  return DateTime(year, month, day).dateOnly;
}

String timeOnly(DateTime date) {
  return "${date.hour}:${date.minute}:${date.second}";
}
