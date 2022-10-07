import 'package:week_day_picker/src/helpers/widget_helper.dart';
import 'package:week_day_picker/src/models/month_model.dart';

class MonthList {
  final MonthModel month;
  final List<MonthModel> months;

  const MonthList({required this.month, required this.months});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthList &&
          runtimeType == other.runtimeType &&
          month == other.month &&
          listEquality(months, other.months);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        month,
        months,
      );

  @override
  String toString() {
    return 'MonthList(month:$month, months :$months)';
  }
}
