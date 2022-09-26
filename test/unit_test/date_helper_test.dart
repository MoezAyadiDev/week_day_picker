import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:week_day_picker/src/helpers/date_helper.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/week_day_picker.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DateTime today;
  late DateTime firstDate;
  late DateTime lastDate;
  late List<DayModel> expectedDayList;
  setUp(() {
    today = DateTime(2022, 09, 30);
    firstDate = DateTime(2021, 1, 13);
    lastDate = DateTime(2023, 10, 19);
    expectedDayList = [
      DayModel(day: DateTime(2022, 9, 30), title: 'Friday', isAllowed: true),
      DayModel(day: DateTime(2022, 10, 1), title: 'Saturday', isAllowed: true),
      DayModel(day: DateTime(2022, 10, 2), title: 'Sunday', isAllowed: true),
      DayModel(day: DateTime(2022, 10, 3), title: 'Monday', isAllowed: true),
      DayModel(day: DateTime(2022, 10, 4), title: 'Tuesday', isAllowed: true),
      DayModel(day: DateTime(2022, 10, 5), title: 'Wednesday', isAllowed: true),
      DayModel(day: DateTime(2022, 10, 6), title: 'Thursday', isAllowed: true),
    ];
  });

  group('Get Days Months Years :', () {
    test('getDay', () {
      //

      //
      List<DayModel> dayList = getDay(
        today,
        firstDate,
        lastDate,
        null,
        null,
        BitwiseOperator.and,
      );

      //
      expect(dayList, expectedDayList);
    });

    test('getMonth', () {
      //

      List<MonthModel> expectedYearList = const [
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
      //
      List<MonthModel> yearList = getMonth(firstDate, lastDate, today);

      //
      expect(yearList, expectedYearList);
    });

    test('getYear', () {
      //
      List<int> expectedYearList = [2021, 2022, 2023];
      //
      List<int> yearList = getYear(firstDate, lastDate);

      //
      expect(yearList, expectedYearList);
    });
  });

  group('lastWeekCheek :', () {
    test('Return false when is Not last Week', () {
      //
      //
      bool isLastWeek = lastWeekCheek(expectedDayList, lastDate);

      //
      expect(isLastWeek, false);
    });
    test('Return true when is the last Week', () {
      //
      //
      bool isLastWeek = lastWeekCheek(expectedDayList, today);

      //
      expect(isLastWeek, true);
    });
  });

  group('FirstWeekCheek :', () {
    test('Return false when is Not first Week', () {
      //
      //
      bool isLastWeek = firstWeekCheek(expectedDayList, firstDate);

      //
      expect(isLastWeek, false);
    });
    test('Return true when is the first Week', () {
      //
      //
      bool isLastWeek = firstWeekCheek(expectedDayList, today);

      //
      expect(isLastWeek, true);
    });
  });

  group('isAllowedDate :', () {
    late BitwiseOperator opAnd;
    late BitwiseOperator opOr;
    late DateTime otherDay;
    setUp(() {
      otherDay = dateOnlyCompose(2022, 2, 15);
      opAnd = BitwiseOperator.and;
      opOr = BitwiseOperator.or;
    });
    test(
        'Return true whene day between firstDate and lastDate and selecatbles days null',
        () {
      bool isLastWeek =
          isAllowedDay(today, firstDate, lastDate, null, null, opAnd);
      expect(isLastWeek, true);
    });
    test('Return true whene day equal firstDate and selecatbles days null', () {
      bool isLastWeek =
          isAllowedDay(firstDate, firstDate, lastDate, null, null, opAnd);
      expect(isLastWeek, true);
    });

    test('Return false whene day is before firstDate and selecatbles days null',
        () {
      bool isLastWeek =
          isAllowedDay(firstDate, today, lastDate, null, null, opAnd);
      expect(isLastWeek, false);
    });

    test('Return false whene day is after lastDate and selecatbles days null',
        () {
      bool isLastWeek =
          isAllowedDay(lastDate, firstDate, today, null, null, opAnd);
      expect(isLastWeek, false);
    });
    group('Selectables Day and Week', () {
      test('Return TRUE whene day IN SelectableDay and BitwiseOperator AND',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [today], null, opAnd);
        expect(isLastWeek, true);
      });
      test('Return TRUE whene day IN SelectableDay and BitwiseOperator OR', () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [today], null, opOr);
        expect(isLastWeek, true);
      });
      test(
          'Return FALSE whene day NOT IN SelectableDay and BitwiseOperator AND',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [otherDay], null, opAnd);
        expect(isLastWeek, false);
      });
      test('Return FALSE whene day NOT IN SelectableDay and BitwiseOperator OR',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [otherDay], null, opOr);
        expect(isLastWeek, false);
      });

      //

      test('Return TRUE whene day IN SelectableDayWeek and BitwiseOperator AND',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, null, [1, 5], opAnd);
        expect(isLastWeek, true);
      });
      test('Return TRUE whene day IN SelectableDayWeek and BitwiseOperator OR',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, null, [1, 5], opOr);
        expect(isLastWeek, true);
      });
      test(
          'Return FALSE whene day NOT IN SelectableDayWeek and BitwiseOperator AND',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, null, [1], opAnd);
        expect(isLastWeek, false);
      });
      test(
          'Return FALSE whene day NOT IN SelectableDayWeek and BitwiseOperator OR',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, null, [1], opOr);
        expect(isLastWeek, false);
      });

      test('Return FALSE whene two selectable NOT IN and BitwiseOperator AND',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [otherDay], [1], opAnd);
        expect(isLastWeek, false);
      });

      test('Return FALSE whene two selectable NOT IN and BitwiseOperator Or',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [otherDay], [1], opOr);
        expect(isLastWeek, false);
      });
      test('Return FALSE whene only selectable Day IN and BitwiseOperator And',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [today], [1], opAnd);
        expect(isLastWeek, false);
      });
      test(
          'Return FALSE whene only selectable DayWeek IN and BitwiseOperator And',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [otherDay], [5], opAnd);
        expect(isLastWeek, false);
      });
      test('Return TRUE whene only selectable Day IN and BitwiseOperator Or',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [today], [1], opOr);
        expect(isLastWeek, true);
      });
      test(
          'Return TRUE whene only selectable DayWeek IN and BitwiseOperator Or',
          () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [otherDay], [5], opOr);
        expect(isLastWeek, true);
      });
      test('Return TRUE whene tow selectable IN and BitwiseOperator And', () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [today], [5], opAnd);
        expect(isLastWeek, true);
      });
      test('Return TRUE whene tow selectable IN and BitwiseOperator Or', () {
        bool isLastWeek =
            isAllowedDay(today, firstDate, lastDate, [today], [5], opOr);
        expect(isLastWeek, true);
      });
    });
  });
}
