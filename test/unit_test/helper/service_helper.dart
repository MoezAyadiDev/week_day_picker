import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/models/month_model.dart';

class TestHelper {
  static const List<MonthModel> expectedMonthModel = [
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
  static const List<MonthModel> expectedMonthModelSameYear = [
    MonthModel(count: 5, month: 'May'),
    MonthModel(count: 6, month: 'June'),
    MonthModel(count: 7, month: 'July'),
    MonthModel(count: 8, month: 'August'),
    MonthModel(count: 9, month: 'September'),
    MonthModel(count: 10, month: 'October'),
    MonthModel(count: 11, month: 'November'),
  ];

  static List<DayModel> dayModelBuilder(DateTime firstDate,
      [List<int> isNotAllowed = const []]) {
    List<DayModel> days = [];
    DateTime dateTemp = firstDate;
    for (int i = 0; i < 7; i++) {
      days.add(
        DayModel(
          day: dateTemp.dateOnly,
          title: DateFormat("EEEE").format(dateTemp).capitalize(),
          isAllowed: !isNotAllowed.contains(i),
        ),
      );
      dateTemp = dateTemp.add(const Duration(days: 1));
    }
    return days;
  }
}
