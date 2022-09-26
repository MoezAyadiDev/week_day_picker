import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/widgets/dialog_widget.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

enum BitwiseOperator { and, or }

class WeekDayPicker {
  ///The application context
  final BuildContext context;

  /// The initially selected [DateTime] that the picker should display.
  final DateTime? initialDate;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The list of selectable [DateTime] that the user can select.
  final List<DateTime>? selectableDay;

  /// The list of selectable Day in week that the user can select.
  ///
  /// Monday = 1 ... Sunday = 7
  final List<int>? selectableDayInWeek;

  /// The bitwise operators for [selectableDay] and [selectableDayInWeek]
  ///
  /// by default is [BitwiseOperator.and]
  final BitwiseOperator selectableBitwiseOperator;

  /// Shows a dialog containing a Material Design date picker.
  ///
  /// When the widget displayed, it will show the month of and the year
  /// [initialDate], with [initialDate] selected.
  ///
  /// The [firstDate] is the earliest allowable date. The [lastDate] is the latest
  /// allowable date. [initialDate] must either fall between these dates,
  /// or be equal to one of them. For each of these [DateTime] parameters, only
  /// their dates are considered. Their time fields are ignored. They must all
  /// be non-null.
  ///
  /// [selectableDay] : The list of selectable [DateTime] that the user can select.
  ///
  /// [selectableDayInWeek] : The list of selectable Day in week that the user can select.
  ///
  /// Monday = 1 ... Sunday = 7
  ///
  /// [selectableBitwiseOperator] : The bitwise operators for [selectableDay] and [selectableDayInWeek]
  ///
  /// by default is [BitwiseOperator.and]
  ///
  WeekDayPicker({
    required this.context,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.selectableDay,
    this.selectableDayInWeek,
    this.selectableBitwiseOperator = BitwiseOperator.and,
  }) {
    assert(
      !lastDate.isBefore(firstDate),
      'lastDate $lastDate must be on or after firstDate $firstDate.',
    );
    if (initialDate != null) {
      assert(
        !initialDate!.isBefore(firstDate),
        'initialDate $initialDate must be on or after firstDate $firstDate.',
      );
      assert(
        !initialDate!.isAfter(lastDate),
        'initialDate $initialDate must be on or before lastDate $lastDate.',
      );
    }

    if (selectableDayInWeek != null) {
      assert(
        selectableDayInWeek!.every((element) => element > 0 && element < 8),
        'selectableDayInWeek $selectableDayInWeek must be between 1 (Monday) and 7 (Sunday)',
      );
    }
  }

  ///Show the weekDayWidget
  ///
  Future<DateTime?> show() async {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      debugPrint(
          '${record.sequenceNumber.toString().padRight(3)}: ${record.level.name} - [${record.loggerName.padRight(20, '.')}]: '
          '${timeOnly(record.time)}: ${record.message}');
    });

    DateTime? selectedDate = await showGeneralDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      pageBuilder: (context, anim1, anim2) {
        Locale myLocale = Localizations.localeOf(context);
        Intl.defaultLocale = myLocale.toString();
        return WeekDayWidget(
          initialDate: (initialDate != null) ? dateOnly(initialDate!) : null,
          firstDate: dateOnly(firstDate),
          lastDate: dateOnly(lastDate),
          selectableDay: selectableDay,
          selectableDayInWeek: selectableDayInWeek,
          selectableBitwiseOperator: selectableBitwiseOperator,
          child: const DialogWidget(),
        );
      },
    );
    return selectedDate;
  }
}
