import 'package:flutter_test/flutter_test.dart';
import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_list.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/services/week_day_service.dart';
import 'package:week_day_picker/src/states/settings_state.dart';
import 'package:week_day_picker/src/states/weekday_state.dart';
import 'package:week_day_picker/week_day_picker.dart';
import 'helper/service_helper.dart';

void main() {
  late SettingsState settingsSimple;
  late DateTime now;
  setUpAll(() {
    settingsSimple = SettingsState(
      currentDate: DateTime(2022, 09, 29).dateOnly,
      firstDate: DateTime(2021, 5, 13).dateOnly,
      lastDate: DateTime(2023, 10, 19).dateOnly,
      selectableDay: null,
      selectableDayInWeek: null,
      selectableBitwiseOperator: BitwiseOperator.and,
    );
    now = dateOnlyCompose(2022, 10, 4);
  });
  group('[WeekDayState]', () {
    group(' - [Init]', () {
      late WeekDayService service;
      setUp(() {
        service = WeekDayService(settings: settingsSimple);
      });

      test('Initial value null', () {
        WeekDayState state = WeekDayState(service: service);
        expect(state.selectedDate.value, null);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(DateTime(2022, 09, 29)),
        );
        expect(
          state.months.value,
          MonthList(
            month: MonthModel.dayToMonthModel(DateTime(2022, 09, 29)),
            months: TestHelper.expectedMonthModel,
          ),
        );
        expect(state.year.value, 2022);
        expect(state.years, [2021, 2022, 2023]);
        expect(state.isLast.value, false);
        expect(state.isFirst.value, false);
      });
      test('Initial value not null', () {
        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: now,
        );
        expect(state.selectedDate.value, now.dateOnly);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(service.getFirstDateOfWeek(now)),
        );
        expect(
          state.months.value,
          MonthList(
            month: MonthModel.dayToMonthModel(service.getFirstDateOfWeek(now)),
            months: TestHelper.expectedMonthModel,
          ),
        );
        expect(state.year.value, 2022);
        expect(state.years, [2021, 2022, 2023]);
        expect(state.isLast.value, false);
        expect(state.isFirst.value, false);
      });
    });

    test('selectedDateChanged', () {
      DateTime newSelectedDate = DateTime(2022, 10, 3).dateOnly;

      WeekDayService service = WeekDayService(settings: settingsSimple);
      WeekDayState state = WeekDayState(
        service: service,
        initialDate: now,
      );
      state.selectedDateChanged(newSelectedDate);
      expect(state.selectedDate.value, newSelectedDate);
    });

    test('selectedMonthChanged', () {
      MonthModel newSelectedMonth = const MonthModel(count: 4, month: 'April');

      WeekDayService service = WeekDayService(settings: settingsSimple);
      WeekDayState state = WeekDayState(
        service: service,
        initialDate: now,
      );
      state.selectedMonthChanged(newSelectedMonth);
      expect(state.months.value.month, newSelectedMonth);
      expect(
        state.days.value,
        TestHelper.dayModelBuilder(
          service.getDateYearChanged(
            state.year.value,
            newSelectedMonth.count,
            state.days.value[0].day.day,
          ),
        ),
      );
    });

    test('selectedYearChanged', () {
      int newSelectedYear = 2021;

      WeekDayService service = WeekDayService(settings: settingsSimple);
      WeekDayState state = WeekDayState(
        service: service,
        initialDate: now,
      );
      state.selectedYearChanged(newSelectedYear);
      expect(state.year.value, newSelectedYear);
      expect(
        state.months.value,
        MonthList(
          month: TestHelper.expectedMonthModel[8],
          months: [
            ...TestHelper.expectedMonthModelSameYear,
            TestHelper.expectedMonthModel[11],
          ],
        ),
      );
      expect(
        state.days.value,
        TestHelper.dayModelBuilder(
          service.getFirstDateOfWeek(
            DateTime(2021, 09, 29).dateOnly,
          ),
        ),
      );
    });

    group('NextWeek', () {
      test('NextWeek Same month', () {
        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: now,
        );
        state.nextWeek();
        expect(state.year.value, 2022);
        expect(state.months.value.month, TestHelper.expectedMonthModel[9]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(now.add(const Duration(days: 7))),
          ),
        );
      });

      test('NextWeek diffirent month', () {
        DateTime newNow = DateTime(2022, 5, 29).dateOnly;

        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: newNow,
        );
        state.nextWeek();
        expect(state.year.value, 2022);
        expect(state.months.value.month, TestHelper.expectedMonthModel[5]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(newNow.add(const Duration(days: 7))),
          ),
        );
      });

      test('NextWeek diffirent month day not in', () {
        DateTime newNow = DateTime(2022, 1, 31).dateOnly;

        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: newNow,
        );
        state.nextWeek();
        expect(state.year.value, 2022);
        expect(state.months.value.month, TestHelper.expectedMonthModel[1]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(newNow.add(const Duration(days: 7))),
          ),
        );
      });
      test('NextWeek diffirent month and diffirent year', () {
        DateTime newNow = DateTime(2022, 12, 30).dateOnly;

        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: newNow,
        );
        state.nextWeek();
        expect(state.year.value, 2023);
        expect(state.months.value.month, TestHelper.expectedMonthModel[0]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(newNow.add(const Duration(days: 7))),
          ),
        );
      });
    });

    group('LastWeek', () {
      test('LastWeek Same month', () {
        WeekDayService service = WeekDayService(settings: settingsSimple);
        DateTime newNow = now.add(const Duration(days: 10));
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: newNow,
        );
        state.previousWeek();
        expect(state.year.value, 2022);
        expect(state.months.value.month, TestHelper.expectedMonthModel[9]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(newNow.add(const Duration(days: -7))),
          ),
        );
      });

      test('LastWeek diffirent month', () {
        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: now,
        );
        state.previousWeek();
        expect(state.year.value, 2022);
        expect(state.months.value.month, TestHelper.expectedMonthModel[8]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(now.add(const Duration(days: -7))),
          ),
        );
      });

      test('lastWeek diffirent month day not in', () {
        DateTime newNow = DateTime(2022, 3, 1).dateOnly;

        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: newNow,
        );
        state.previousWeek();
        expect(state.year.value, 2022);
        expect(state.months.value.month, TestHelper.expectedMonthModel[1]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(newNow.add(const Duration(days: -7))),
          ),
        );
      });
      test('lasttWeek diffirent month and diffirent year', () {
        DateTime newNow = DateTime(2022, 1, 2).dateOnly;

        WeekDayService service = WeekDayService(settings: settingsSimple);
        WeekDayState state = WeekDayState(
          service: service,
          initialDate: newNow,
        );
        state.previousWeek();
        expect(state.year.value, 2021);
        expect(state.months.value.month, TestHelper.expectedMonthModel[11]);
        expect(
          state.days.value,
          TestHelper.dayModelBuilder(
            service.getFirstDateOfWeek(newNow.add(const Duration(days: -7))),
          ),
        );
      });
    });
  });
}
