import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class MonthModel {
  final String month;
  final int count;

  const MonthModel({required this.month, required this.count});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthModel &&
          runtimeType == other.runtimeType &&
          month == other.month &&
          count == other.count;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        month,
        count,
      );

  @override
  String toString() {
    return month;
    //return 'MonthModel(count:$count,  month:\'$month\')';
  }

  MonthModel.dayToMonthModel(DateTime date)
      : month = DateFormat("MMMM").format(date).capitalize(),
        count = date.month;
}
