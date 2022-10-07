import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/week_day_picker.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class SettingsState {
  final DateTime currentDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<DateTime>? selectableDay;
  final List<int>? selectableDayInWeek;
  final BitwiseOperator selectableBitwiseOperator;
  SettingsState({
    DateTime? currentDate,
    required this.firstDate,
    required this.lastDate,
    required this.selectableDay,
    required this.selectableDayInWeek,
    required this.selectableBitwiseOperator,
  }) : currentDate = currentDate?.dateOnly ?? dateOnly(DateTime.now());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsState &&
          runtimeType == other.runtimeType &&
          currentDate == other.currentDate &&
          firstDate == other.firstDate &&
          lastDate == other.lastDate &&
          selectableDay == other.selectableDay &&
          selectableDayInWeek == other.selectableDayInWeek &&
          selectableBitwiseOperator == other.selectableBitwiseOperator;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        currentDate,
        firstDate,
        lastDate,
        selectableDay,
        selectableDayInWeek,
        selectableBitwiseOperator,
      );

  @override
  String toString() {
    return 'SettingsState(currentDate: $currentDate,  firstDate: $firstDate, '
        'lastDate: $lastDate, selectableDay:$selectableDay, '
        'selectableDayInWeek: $selectableDayInWeek, '
        'selectableBitwiseOperator: $selectableBitwiseOperator';
  }
}
