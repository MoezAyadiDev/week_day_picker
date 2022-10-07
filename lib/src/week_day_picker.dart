import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/services/week_day_service.dart';
import 'package:week_day_picker/src/states/settings_state.dart';
import 'package:week_day_picker/src/states/weekday_provider.dart';
import 'package:week_day_picker/src/states/weekday_state.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

enum BitwiseOperator { and, or }

class WeekDayPicker {
  ///The application context
  final BuildContext context;

  /// When the date picker is first displayed, it will show the month of
  /// [initialDate], with [initialDate] selected.
  final DateTime? initialDate;

  /// The [currentDate] represents the current day (i.e. today). This
  /// date will be highlighted in the day grid. If null, the date of
  /// `DateTime.now()` will be used.
  final DateTime? currentDate;

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

  ///
  ///The header background
  final Color? colorHeader;

  ///
  ///The text on header
  final Color? colorOnHeader;

  ///The color of :
  ///- Next & previous Icon
  ///- The Button Text ok and Cancel
  final Color? colorIcon;

  ///The color whene the day is not aalowed or last and first week not allowed :
  ///It take effect on
  ///- Next & previous Icon
  ///- The item in date
  final Color? colorDisabled;

  ///The beckground color of selected item
  final Color? colorSelected;

  ///The text color of selected item
  final Color? colorOnSelected;

  ///The background Color
  final Color? backgroundColor;

  /// Shows a dialog containing a Material Design date picker.
  ///
  /// When the widget displayed, it will show the month of and the year
  /// [initialDate], with [initialDate] selected.
  ///
  /// The [currentDate] represents the current day (i.e. today). This
  /// date will be highlighted in the day grid. If null, the date of
  /// `DateTime.now()` will be used.
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
  ///
  ///[colorHeader] The header background
  ///
  ///[colorOnHeader] The text color on header
  ///
  ///[colorIcon] The color of :
  ///- Next & previous Icon
  ///- The Button Text ok and Cancel
  ///[colorDisabled] The color whene the day is not aalowed or last and first week not allowed :
  ///It take effect on
  ///- Next & previous Icon
  ///- The item in date if is not allowed
  ///
  ///[colorSelected] The beckground color of selected item
  ///
  ///[colorOnSelected] The text color of selected item
  ///
  WeekDayPicker({
    required this.context,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.currentDate,
    this.selectableDay,
    this.selectableDayInWeek,
    this.selectableBitwiseOperator = BitwiseOperator.and,
    this.colorHeader,
    this.colorOnHeader,
    this.colorIcon,
    this.colorDisabled,
    this.colorSelected,
    this.colorOnSelected,
    this.backgroundColor,
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
    Logger.root.level = Level.WARNING; // defaults to Level.INFO
    Logger.root.clearListeners();
    Logger.root.onRecord.listen((record) {
      debugPrint(
          '${record.sequenceNumber.toString().padRight(3)}: ${record.level.name} - [${record.loggerName.padRight(20, '.')}]: '
          '${timeOnly(record.time)}: ${record.message}');
    });
    //Todo : add RestorableValue
    SettingsState settings = SettingsState(
      firstDate: firstDate.dateOnly,
      lastDate: lastDate.dateOnly,
      currentDate: currentDate?.dateOnly,
      selectableDay: selectableDay?.map((e) => e.dateOnly).toList(),
      selectableDayInWeek: selectableDayInWeek,
      selectableBitwiseOperator: selectableBitwiseOperator,
    );
    WeekDayService service = WeekDayService(
      settings: settings,
    );
    WeekDayState weekDayState = WeekDayState(
      service: service,
      initialDate: initialDate,
    );
    DateTime? selectedDate = await showGeneralDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      pageBuilder: (context, anim1, anim2) {
        Locale myLocale = Localizations.localeOf(context);
        Intl.defaultLocale = myLocale.toString();
        var log = Logger('showGeneralDialog');
        log.fine('build');
        return WeekDayProvider(
          weekDayState: weekDayState,
          child: WeekDayWidget(
            headerColor: colorHeader,
            onHeaderColor: colorOnHeader,
            iconColor: colorIcon,
            disableColor: colorDisabled,
            selectedColor: colorSelected,
            onSelectedColor: colorOnSelected,
            backgroundColor: backgroundColor,
          ),
        );
      },
    );
    return selectedDate;
  }
}
