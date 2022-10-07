import 'package:flutter_test/flutter_test.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_list.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/services/week_day_service.dart';
import 'package:week_day_picker/src/states/settings_state.dart';
import 'package:week_day_picker/week_day_picker.dart';

import 'helper/service_helper.dart';

void main() {
  late DateTime firstDate;
  late DateTime lastDate;
  late SettingsState settingsMin;
  late SettingsState settingsInitalDate;
  late SettingsState settingsSameYear;
  late DateTime today;
  late DateTime currentDate;
  late DateTime lastDateSameYear;
  setUp(() {
    firstDate = DateTime(2021, 5, 13).dateOnly;
    lastDate = DateTime(2023, 10, 19).dateOnly;
    today = DateTime(2022, 09, 23).dateOnly;
    currentDate = DateTime(2022, 09, 29).dateOnly;
    lastDateSameYear = DateTime(firstDate.year, 11, 5).dateOnly;
    settingsMin = SettingsState(
      currentDate: null,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDay: null,
      selectableDayInWeek: null,
      selectableBitwiseOperator: BitwiseOperator.and,
    );
    settingsInitalDate = SettingsState(
      currentDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDay: null,
      selectableDayInWeek: null,
      selectableBitwiseOperator: BitwiseOperator.and,
    );
    settingsSameYear = SettingsState(
      currentDate: null,
      firstDate: firstDate,
      lastDate: lastDateSameYear,
      selectableDay: null,
      selectableDayInWeek: null,
      selectableBitwiseOperator: BitwiseOperator.and,
    );
  });

  group('[SettingsState]', () {
    test(
      'return DateTime.now() when inital date in settings IS NULL',
      () {
        expect(settingsMin.currentDate, DateTime.now().dateOnly);
      },
    );
    test(
      'return CORRECT currentDate ',
      () {
        expect(settingsInitalDate.currentDate, currentDate);
      },
    );

    test(
      'return First Date when currentDate before current date',
      () {
        expect(settingsInitalDate.currentDate, currentDate);
      },
    );
  });
  group(
    '[Service]',
    () {
      group(
        'getYear :',
        () {
          test(
            'Different year',
            () {
              WeekDayService service = WeekDayService(settings: settingsMin);
              var years1 = service.getYears();
              expect(years1, [2021, 2022, 2023]);
            },
          );
          test(
            'Same year',
            () {
              WeekDayService service =
                  WeekDayService(settings: settingsSameYear);
              var years2 = service.getYears();
              expect(years2, [2021]);
            },
          );
        },
      );

      group('getMonhs :', () {
        test(
          'Different year, Day between First and Last Day',
          () {
            WeekDayService service1 = WeekDayService(settings: settingsMin);
            var months1 = service1.getMonths(today);
            expect(
              months1,
              MonthList(
                month: MonthModel.dayToMonthModel(today),
                months: TestHelper.expectedMonthModel,
              ),
            );
          },
        );
        test(
          'Same year, Day between First and Last Day',
          () {
            DateTime dayBetween = DateTime(2021, 09, 30);
            WeekDayService service1 =
                WeekDayService(settings: settingsSameYear);
            var months1 = service1.getMonths(dayBetween);
            expect(
              months1,
              MonthList(
                month: MonthModel.dayToMonthModel(dayBetween),
                months: TestHelper.expectedMonthModelSameYear,
              ),
            );
          },
        );
        test(
          'Same year, Day before First day',
          () {
            DateTime dayBefore = DateTime(2021, 3, 13);
            WeekDayService service2 =
                WeekDayService(settings: settingsSameYear);
            var months2 = service2.getMonths(dayBefore);
            expect(
              months2,
              MonthList(
                month: MonthModel.dayToMonthModel(firstDate),
                months: TestHelper.expectedMonthModelSameYear,
              ),
            );
          },
        );
        test(
          'Same year, Day after last day',
          () {
            DateTime dayAfter = DateTime(2021, 12, 5);
            WeekDayService service2 =
                WeekDayService(settings: settingsSameYear);
            var months2 = service2.getMonths(dayAfter);
            expect(
              months2,
              MonthList(
                month: MonthModel.dayToMonthModel(lastDateSameYear),
                months: TestHelper.expectedMonthModelSameYear,
              ),
            );
          },
        );
        test(
          'Different year, Day null',
          () {
            WeekDayService service1 = WeekDayService(settings: settingsMin);
            var months1 = service1.getMonths(null);
            expect(
              months1,
              MonthList(
                month: MonthModel.dayToMonthModel(DateTime.now()),
                months: TestHelper.expectedMonthModel,
              ),
            );
          },
        );
      });

      group('getDay :', () {
        late SettingsState settingsSelectableDayAnd;
        late SettingsState settingsSelectableDayOr;
        late SettingsState settingsSelectableWeekAnd;
        late SettingsState settingsSelectableWeekOr;
        setUp(() {
          settingsSelectableDayAnd = SettingsState(
            currentDate: today,
            firstDate: firstDate,
            lastDate: lastDate,
            selectableDay: [today],
            selectableDayInWeek: [1, 5],
            selectableBitwiseOperator: BitwiseOperator.and,
          );
          settingsSelectableDayOr = SettingsState(
            currentDate: today,
            firstDate: firstDate,
            lastDate: lastDate,
            selectableDay: [today],
            selectableDayInWeek: [1, 5],
            selectableBitwiseOperator: BitwiseOperator.or,
          );
          settingsSelectableWeekAnd = SettingsState(
            currentDate: today,
            firstDate: firstDate,
            lastDate: lastDate,
            selectableDay: [today],
            selectableDayInWeek: [1, 4],
            selectableBitwiseOperator: BitwiseOperator.and,
          );
          settingsSelectableWeekOr = SettingsState(
            currentDate: today,
            firstDate: firstDate,
            lastDate: lastDate,
            selectableDay: [today],
            selectableDayInWeek: [1, 4],
            selectableBitwiseOperator: BitwiseOperator.or,
          );
        });

        group('[Selectable null]', () {
          test('return TRUE when Day BETWEEN first Date and last Date', () {
            WeekDayService service1 = WeekDayService(settings: settingsMin);
            var isAllowed1 = service1.isAllowedDay(today);
            expect(isAllowed1, true);
          });
          test('return FALSE when Day is BEFORE Fisrt Date', () {
            WeekDayService service1 = WeekDayService(settings: settingsMin);
            var isAllowedOutOfRange1 = service1.isAllowedDay(DateTime(2020));
            expect(isAllowedOutOfRange1, false);
          });
          test('return FALSE when Day is AFTER Fisrt Date', () {
            WeekDayService service1 = WeekDayService(settings: settingsMin);
            var isAllowedOutOfRange1 = service1.isAllowedDay(DateTime(2026));
            expect(isAllowedOutOfRange1, false);
          });
        });

        group('[Selectable Date]', () {
          late SettingsState settingsSelectableDayAnd;
          late SettingsState settingsSelectableDayOr;
          setUp(() {
            settingsSelectableDayAnd = SettingsState(
              currentDate: today,
              firstDate: firstDate,
              lastDate: lastDate,
              selectableDay: [today],
              selectableDayInWeek: null,
              selectableBitwiseOperator: BitwiseOperator.and,
            );
            settingsSelectableDayOr = SettingsState(
              currentDate: today,
              firstDate: firstDate,
              lastDate: lastDate,
              selectableDay: [today],
              selectableDayInWeek: null,
              selectableBitwiseOperator: BitwiseOperator.or,
            );
          });

          test('return TRUE when Day is selectable', () {
            WeekDayService service1 =
                WeekDayService(settings: settingsSelectableDayAnd);
            WeekDayService service2 =
                WeekDayService(settings: settingsSelectableDayOr);
            var isAllowed1 = service1.isAllowedDay(today);
            var isAllowed2 = service2.isAllowedDay(today);
            expect(isAllowed1, true);
            expect(isAllowed2, true);
          });
          test('return FALSE when Day is in selectable day', () {
            WeekDayService service1 =
                WeekDayService(settings: settingsSelectableDayAnd);
            WeekDayService service2 =
                WeekDayService(settings: settingsSelectableDayOr);
            var isAllowed1 =
                service1.isAllowedDay(today.add(const Duration(days: 1)));
            var isAllowed2 =
                service2.isAllowedDay(today.add(const Duration(days: 1)));
            expect(isAllowed1, false);
            expect(isAllowed2, false);
          });
        });

        group('getDays', () {
          group('[SelectableWeek Day]', () {
            late SettingsState settingsSelectableDayAnd;
            late SettingsState settingsSelectableDayOr;
            setUp(() {
              settingsSelectableDayAnd = SettingsState(
                currentDate: today,
                firstDate: firstDate,
                lastDate: lastDate,
                selectableDay: null,
                selectableDayInWeek: [1, 5],
                selectableBitwiseOperator: BitwiseOperator.and,
              );
              settingsSelectableDayOr = SettingsState(
                currentDate: today,
                firstDate: firstDate,
                lastDate: lastDate,
                selectableDay: null,
                selectableDayInWeek: [1, 5],
                selectableBitwiseOperator: BitwiseOperator.or,
              );
            });

            test('return TRUE when Day is selectable', () {
              WeekDayService service1 =
                  WeekDayService(settings: settingsSelectableDayAnd);
              WeekDayService service2 =
                  WeekDayService(settings: settingsSelectableDayOr);
              var isAllowed1 = service1.isAllowedDay(today);
              var isAllowed2 = service2.isAllowedDay(today);
              expect(isAllowed1, true);
              expect(isAllowed2, true);
            });
            test('return FALSE when Day is not selectable', () {
              WeekDayService service1 =
                  WeekDayService(settings: settingsSelectableDayAnd);
              WeekDayService service2 =
                  WeekDayService(settings: settingsSelectableDayOr);
              var isAllowed1 =
                  service1.isAllowedDay(today.add(const Duration(days: 1)));
              var isAllowed2 =
                  service2.isAllowedDay(today.add(const Duration(days: 1)));
              expect(isAllowed1, false);
              expect(isAllowed2, false);
            });
          });
          group('[Selectable Mixe]', () {
            test('return TRUE when Day is selectable', () {
              WeekDayService service1 =
                  WeekDayService(settings: settingsSelectableDayAnd);
              WeekDayService service2 =
                  WeekDayService(settings: settingsSelectableDayOr);
              var isAllowed1 = service1.isAllowedDay(today);
              var isAllowed2 = service2.isAllowedDay(today);
              expect(isAllowed1, true);
              expect(isAllowed2, true);
            });
            test('return FALSE when Day is not selectable', () {
              WeekDayService service1 =
                  WeekDayService(settings: settingsSelectableDayAnd);
              WeekDayService service2 =
                  WeekDayService(settings: settingsSelectableDayOr);
              var isAllowed1 =
                  service1.isAllowedDay(today.add(const Duration(days: 1)));
              var isAllowed2 =
                  service2.isAllowedDay(today.add(const Duration(days: 1)));
              expect(isAllowed1, false);
              expect(isAllowed2, false);
            });
            test(
                'return TRUE when Day is in Selectable Day and not in Week OPERATOR OR',
                () {
              WeekDayService service2 =
                  WeekDayService(settings: settingsSelectableWeekOr);
              var isAllowed2 = service2.isAllowedDay(today);
              expect(isAllowed2, true);
            });
            test(
                'return FALSE when Day is in Selectable Day and not in Week OPERATOR AND',
                () {
              WeekDayService service2 =
                  WeekDayService(settings: settingsSelectableWeekAnd);
              var isAllowed2 = service2.isAllowedDay(today);
              expect(isAllowed2, false);
            });
          });
        });

        test('Initial Date null', () {
          WeekDayService service1 = WeekDayService(settings: settingsMin);
          var days = service1.getDay(null);
          expect(days, TestHelper.dayModelBuilder(DateTime.now()));
        });

        test('Initial Date not null', () {
          WeekDayService service1 =
              WeekDayService(settings: settingsInitalDate);
          var days = service1.getDay(today);
          expect(days, TestHelper.dayModelBuilder(DateTime(2022, 9, 22)));
        });
        test('Initial Date not bewtween date', () {
          WeekDayService service1 = WeekDayService(
            settings: settingsInitalDate,
          );
          var days = service1.getDay(DateTime(2026));
          expect(
              days,
              TestHelper.dayModelBuilder(
                DateTime(2023, 10, 19),
                [1, 2, 3, 4, 5, 6],
              ));
        });
        test('Cheek selectable day', () {
          WeekDayService service1 =
              WeekDayService(settings: settingsSelectableWeekAnd);
          var days = service1.getDay(today);
          expect(
              days,
              TestHelper.dayModelBuilder(
                  DateTime(2022, 9, 23), [0, 1, 2, 3, 4, 5, 6]));
        });
        test('Cheek selectable dayWeek', () {
          WeekDayService service1 =
              WeekDayService(settings: settingsSelectableWeekOr);
          var days = service1.getDay(today);
          expect(
            days,
            TestHelper.dayModelBuilder(
              DateTime(2022, 9, 23),
              [1, 2, 4, 5],
            ),
          );
        });
      });

      group('firstYear', () {
        test('Return Current year when CurrentDate null and RefrenceDate null',
            () {
          WeekDayService service1 = WeekDayService(settings: settingsMin);
          var year = service1.firstYear(null);
          expect(year, DateTime.now().year);
        });
        test(
            'Return CurrentDat Year when CurrentDate not null and RefrenceDate null',
            () {
          WeekDayService service1 = WeekDayService(
            settings: SettingsState(
              currentDate: firstDate,
              firstDate: firstDate,
              lastDate: lastDate,
              selectableDay: null,
              selectableDayInWeek: null,
              selectableBitwiseOperator: BitwiseOperator.and,
            ),
          );
          var year = service1.firstYear(null);
          expect(year, firstDate.year);
        });
        test(
            'Return RefrenceDate year when CurrentDate null and RefrenceDate not null',
            () {
          WeekDayService service1 = WeekDayService(settings: settingsMin);
          var year = service1.firstYear(firstDate);
          expect(year, firstDate.year);
        });
        test(
            'Return RefrenceDate Year when CurrentDate not null and RefrenceDate not null',
            () {
          WeekDayService service1 = WeekDayService(
            settings: SettingsState(
              currentDate: firstDate,
              firstDate: firstDate,
              lastDate: lastDate,
              selectableDay: null,
              selectableDayInWeek: null,
              selectableBitwiseOperator: BitwiseOperator.and,
            ),
          );
          var year = service1.firstYear(lastDate);
          expect(year, lastDate.year);
        });
      });

      group('isLastWeek', () {
        late WeekDayService service1;
        setUp(() {
          service1 = WeekDayService(settings: settingsMin);
        });
        test('Return true when is last week', () {
          var isLastWeek = service1.isLastWeek(lastDate);
          expect(isLastWeek, true);
        });
        test('Return false when is not', () {
          var isLastWeek = service1.isLastWeek(today);
          expect(isLastWeek, false);
        });
      });
      group('isFirstWeek', () {
        late WeekDayService service1;
        setUp(() {
          service1 = WeekDayService(settings: settingsMin);
        });
        test('Return true when is first week', () {
          var isLastWeek =
              service1.isFirstWeek(service1.getFirstDateOfWeek(firstDate));
          expect(isLastWeek, true);
        });
        test('Return false when is not', () {
          var isLastWeek = service1.isFirstWeek(today);
          expect(isLastWeek, false);
        });
      });
      group('getDateYearChanged', () {
        late WeekDayService service1;
        setUp(() {
          service1 = WeekDayService(settings: settingsMin);
        });

        test('Return New Date when is between first Date and last date', () {
          var newDate = service1.getDateYearChanged(2021, 11, 25);
          expect(newDate, newDate);
        });
        test('Return FirstDate when is before first Date', () {
          var newDate = service1.getDateYearChanged(2021, 1, 25);
          expect(newDate, service1.getFirstDateOfWeek(firstDate));
        });
        test('Return lastDate when is after last Date', () {
          var newDate = service1.getDateYearChanged(2025, 1, 25);
          expect(newDate, service1.getFirstDateOfWeek(lastDate));
        });
      });

      group('GetNextWeek', () {
        late WeekDayService service1;
        DateTime now = DateTime.now().dateOnly;
        setUp(() {
          service1 = WeekDayService(settings: settingsMin);
        });
        test('Return new first Date when is not last', () {
          DateTime newDate = service1.getNextWeek(now);
          expect(newDate, now.add(const Duration(days: 7)));
        });
        test(
          'Return same Date when is the last',
          () {
            DateTime firstWeekOfLastDate =
                service1.getFirstDateOfWeek(lastDate);

            DateTime newDate = service1.getNextWeek(firstWeekOfLastDate);
            expect(newDate, firstWeekOfLastDate);
          },
        );
      });
      group('GetLastWeek', () {
        late WeekDayService service1;
        late DateTime now;
        setUp(() {
          service1 = WeekDayService(settings: settingsMin);
          now = DateTime.now().dateOnly;
        });
        test('Return new first Date when is not first week', () {
          DateTime newDate = service1.getLastWeek(now);
          expect(newDate, now.add(const Duration(days: -7)));
        });
        test(
          'Return same Date when is the first week',
          () {
            DateTime firstWeekOfFirstDate =
                service1.getFirstDateOfWeek(firstDate);
            DateTime newDate = service1.getLastWeek(
              firstWeekOfFirstDate,
            );
            expect(
              newDate,
              firstWeekOfFirstDate,
            );
          },
        );
      });

      group('getFirstDateOfWeek', () {
        late SettingsState settings2;
        late DateTime newFirstDate;
        late DateTime newLastDate;
        setUp(() {
          newFirstDate = firstDate.add(const Duration(days: 1));
          newLastDate = lastDate.add(const Duration(days: -3));
          settings2 = SettingsState(
            currentDate: currentDate,
            firstDate: newFirstDate,
            lastDate: newLastDate,
            selectableDay: null,
            selectableDayInWeek: null,
            selectableBitwiseOperator: BitwiseOperator.and,
          );
        });

        test('Get the same Date if is the first Date of week', () {
          WeekDayService service1 = WeekDayService(settings: settings2);
          DateTime firstDateWeek = service1.getFirstDateOfWeek(currentDate);
          expect(firstDateWeek, currentDate);
        });
        test(
          'Get the FirstDate of week when is not the first Date of week (Day +1)',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(
              currentDate.add(const Duration(days: 1)),
            );
            expect(firstDateWeek, currentDate);
          },
        );
        test(
          'Get the FirstDate of week when is not the first Date of week (Day +5)',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(
              currentDate.add(const Duration(days: 5)),
            );
            expect(firstDateWeek, currentDate);
          },
        );
        test(
          'Get the FirstDate of week when is not the first Date of week (Day -1)',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(
              currentDate.add(const Duration(days: -1)),
            );
            expect(firstDateWeek, currentDate.add(const Duration(days: -7)));
          },
        );
        test(
          'Get the FirstDate of week when is not the first Date of week (Day -3)',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(
              currentDate.add(const Duration(days: -1)),
            );
            expect(firstDateWeek, currentDate.add(const Duration(days: -7)));
          },
        );
        test(
          'Get the FirstDate of week when is not the first Date of week (Day -10)',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(
              currentDate.add(const Duration(days: -10)),
            );
            expect(firstDateWeek, currentDate.add(const Duration(days: -14)));
          },
        );
        test(
          'Get the FirstDate of week when is not the first Date of week (Day +10)',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(
              currentDate.add(const Duration(days: 10)),
            );
            expect(firstDateWeek, currentDate.add(const Duration(days: 7)));
          },
        );
        test(
          'Get the First week when is above first Date',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(newFirstDate);
            expect(firstDateWeek, newFirstDate.add(const Duration(days: -1)));
          },
        );
        test(
          'Get the First week when is after last Date',
          () {
            WeekDayService service1 = WeekDayService(settings: settings2);
            DateTime firstDateWeek = service1.getFirstDateOfWeek(newLastDate);
            expect(firstDateWeek, newLastDate.add(const Duration(days: -4)));
          },
        );
      });
    },
  );
}
