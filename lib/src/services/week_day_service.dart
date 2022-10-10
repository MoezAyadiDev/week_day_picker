import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/models/month_list.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/states/settings_state.dart';
import 'package:week_day_picker/week_day_picker.dart';

class WeekDayService {
  final SettingsState _settings;
  WeekDayService({
    required SettingsState settings,
    String locale = 'en',
  }) : _settings = settings {
    Intl.defaultLocale = locale;
  }

  ///Get the list of year from first date and lastDate
  ///
  List<int> getYears() {
    List<int> years = [];
    for (int i = _settings.firstDate.year; i <= _settings.lastDate.year; i++) {
      years.add(i);
    }
    return years;
  }

  ///Get the list of year from first date and lastDate
  ///
  MonthList getMonths(DateTime? referenceDate) {
    List<MonthModel> months = [];
    DateTime temp;
    //Begin Date for the year
    int dayBeginInYear;
    DateTime date = referenceDate ?? _settings.currentDate;
    date = getFirstDateOfWeek(date);
    bool isBetween = true;

    //Change the day if is before first or after last
    if (date.isBefore(_settings.firstDate)) {
      date = _settings.firstDate;
      isBetween = false;
    }

    if (date.isAfter(_settings.lastDate)) {
      date = _settings.lastDate;
      isBetween = false;
    }

    if (date.year <= _settings.firstDate.year) {
      dayBeginInYear = _settings.firstDate.month;
    } else {
      dayBeginInYear = 1;
    }

    //End Date for the year

    int dayEndInYear;
    if (date.year >= _settings.lastDate.year) {
      dayEndInYear = _settings.lastDate.month;
    } else {
      dayEndInYear = 12;
    }

    for (int i = dayBeginInYear; i <= dayEndInYear; i++) {
      temp = DateTime(_settings.firstDate.year, i);
      months.add(
        MonthModel(
          month: DateFormat("MMMM").format(temp).capitalize(),
          count: i,
        ),
      );
    }

    return MonthList(
      months: months,
      month: MonthModel.dayToMonthModel(
        isBetween
            ? (referenceDate != null)
                ? getFirstDateOfWeek(referenceDate)
                : _settings.currentDate
            : date,
      ),
    );
  }

  ///Get the week day from given date
  ///
  ///
  List<DayModel> getDay(DateTime? firstDayInWeek) {
    List<DayModel> days = [];
    DateTime temp = firstDayInWeek ?? _settings.currentDate;
    temp = getFirstDateOfWeek(temp);
    if (temp.isBefore(getFirstDateOfWeek(_settings.firstDate))) {
      temp = getFirstDateOfWeek(_settings.firstDate);
    } else if (temp.isAfter(getFirstDateOfWeek(_settings.lastDate))) {
      temp = getFirstDateOfWeek(_settings.lastDate);
    }
    for (int i = 0; i < 7; i++) {
      days.add(
        DayModel(
          title: DateFormat("EEEE").format(temp).capitalize(),
          day: temp,
          isAllowed: isAllowedDay(temp),
        ),
      );
      temp = temp.add(const Duration(days: 1));
    }
    return days;
  }

  ///Check if a date can be selected
  bool isAllowedDay(DateTime day) {
    if (day.isBefore(_settings.firstDate)) return false;
    if (day.isAfter(_settings.lastDate)) return false;
    if (_settings.selectableDay == null &&
        _settings.selectableDayInWeek == null) {
      return true;
    } else {
      if (_settings.selectableBitwiseOperator == BitwiseOperator.and) {
        if (_settings.selectableDay != null) {
          if (!_settings.selectableDay!.any((element) => element == day)) {
            return false;
          }
        }
        if (_settings.selectableDayInWeek != null) {
          if (!_settings.selectableDayInWeek!
              .any((element) => element == day.weekday)) {
            return false;
          }
        }
        return true;
      } else {
        if (_settings.selectableDay != null) {
          if (_settings.selectableDay!.any((element) => element == day)) {
            return true;
          }
        }
        if (_settings.selectableDayInWeek != null) {
          if (_settings.selectableDayInWeek!
              .any((element) => element == day.weekday)) {
            return true;
          }
        }
        return false;
      }
    }
  }

  int firstYear(DateTime? referenceDate) {
    return referenceDate?.year ?? _settings.currentDate.year;
  }

  DateTime getDateYearChanged(int year, int month, int day) {
    DateTime newDate = dateOnlyCompose(
      year,
      month,
      day,
    );
    if (newDate.isAfter(_settings.lastDate)) {
      newDate = getFirstDateOfWeek(_settings.lastDate);
    }
    if (newDate.isBefore(_settings.firstDate)) {
      newDate = getFirstDateOfWeek(_settings.firstDate);
    }
    return getFirstDateOfWeek(newDate);
  }

  bool isLastWeek(DateTime dayWeek) {
    // print(
    //     'isLastWeek : first day of week of lastDate ${getFirstDateOfWeek(_settings.lastDate)}');
    // print('isLastWeek : dayWeek $dayWeek');

    return dayWeek == getFirstDateOfWeek(_settings.lastDate)
        ? true
        : dayWeek.isAfter(getFirstDateOfWeek(_settings.lastDate));
  }

  bool isFirstWeek(DateTime dayWeek) {
    return dayWeek.isAtSameMomentAs(getFirstDateOfWeek(_settings.firstDate))
        ? true
        : (dayWeek.isBefore(getFirstDateOfWeek(_settings.firstDate)));
  }

  DateTime getLastWeek(DateTime originDate) {
    if (!isFirstWeek(originDate)) {
      DateTime newDate = originDate.add(const Duration(days: -7));
      return newDate;
    } else {
      return originDate;
    }
  }

  DateTime getNextWeek(DateTime originDate) {
    // print('originDate = $originDate');
    // print('lastDate = ${_settings.lastDate}');
    if (!isLastWeek(originDate)) {
      // print('is Not LastWeek');
      DateTime newDate = originDate.add(const Duration(days: 7));
      // print('newDate : newDate');
      return newDate;
    } else {
      // print('is LastWeek');
      // print('originDate : originDate');
      return originDate;
    }
  }

  DateTime getFirstDateOfWeek(DateTime dateToCheck) {
    int nbrDayDiffirence = dateToCheck.weekday - _settings.currentDate.weekday;
    if (nbrDayDiffirence < 0) {
      nbrDayDiffirence = (7 + nbrDayDiffirence);
    }
    return dateToCheck.add(
      Duration(days: -nbrDayDiffirence),
    );
  }

  DateTime get currentdate => _settings.currentDate;
}
