import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/state/week_day_state.dart';
import 'package:week_day_picker/src/week_day_picker.dart';

var kDays = [
  DayModel(
      day: dateOnlyCompose(2022, 09, 24), title: 'Saturday', isAllowed: false),
  DayModel(
      day: dateOnlyCompose(2022, 09, 25), title: 'Sunday', isAllowed: false),
  DayModel(
      day: dateOnlyCompose(2022, 09, 26), title: 'Monday', isAllowed: true),
  DayModel(
      day: dateOnlyCompose(2022, 09, 27), title: 'Tuesday', isAllowed: false),
  DayModel(
      day: dateOnlyCompose(2022, 09, 28), title: 'Wednesday', isAllowed: false),
  DayModel(
      day: dateOnlyCompose(2022, 09, 29), title: 'Thursday', isAllowed: false),
  DayModel(
      day: dateOnlyCompose(2022, 09, 30), title: 'Friday', isAllowed: true),
];

var kMonths = const [
  MonthModel(count: 1, month: 'January'),
  MonthModel(count: 2, month: 'February'),
  MonthModel(count: 3, month: 'March'),
  MonthModel(count: 4, month: 'April'),
  MonthModel(count: 5, month: 'May'),
  MonthModel(count: 6, month: 'June'),
  MonthModel(count: 7, month: 'July'),
  MonthModel(count: 8, month: 'August'),
  MonthModel(count: 9, month: 'September'),
  MonthModel(count: 10, month: 'October'),
  MonthModel(count: 11, month: 'November'),
  MonthModel(count: 12, month: 'December'),
];

WeekDayState kAppState = WeekDayState(
  selectedDate: null,
  lastDate: dateOnlyCompose(2023, 10, 19),
  firstDate: dateOnlyCompose(2021, 1, 13),
  year: 2022,
  month: const MonthModel(count: 9, month: 'September'),
  years: [2021, 2022, 2023],
  months: kMonths,
  days: kDays,
  selectableDay: null,
  selectableDayInWeek: [1, 5],
  selectableBitwiseOperator: BitwiseOperator.and,
  toDayDate: dateOnlyCompose(2022, 09, 24),
);
