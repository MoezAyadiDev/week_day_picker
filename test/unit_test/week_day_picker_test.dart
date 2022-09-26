import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:week_day_picker/src/week_day_picker.dart';
import 'package:flutter/widgets.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext mockContext;
  late DateTime today;
  late DateTime firstDate;
  late DateTime lastDate;

  setUp(() {
    mockContext = MockBuildContext();
    today = DateTime.now();
    firstDate = DateTime(2021, 1, 13);
    lastDate = DateTime(2023, 10, 19);
  });

  group(
    'WeekDayPicker Unit Test - ',
    () {
      test(
        'Throw AssertionError when initial date is befor first date',
        () {
          //
          var firstDate = DateTime(2023);
          var lastDate = DateTime(2023);
          //

          //
          expect(
            () => WeekDayPicker(
              context: mockContext,
              firstDate: firstDate,
              initialDate: today,
              lastDate: lastDate,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'Throw AssertionError when initial date is after last date',
        () {
          //
          var firstDate = DateTime(2021);
          var lastDate = DateTime(2021);
          //

          //
          expect(
            () => WeekDayPicker(
              context: mockContext,
              firstDate: firstDate,
              initialDate: today,
              lastDate: lastDate,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'Throw AssertionError when last date is befor initial date',
        () {
          //
          var firstDate = DateTime(2022);
          var lastDate = DateTime(2021);
          //

          //
          expect(
            () => WeekDayPicker(
              context: mockContext,
              firstDate: firstDate,
              initialDate: today,
              lastDate: lastDate,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'Throw AssertionError when One selectableDayInWeek not in [1..7]',
        () {
          //

          //

          //
          expect(
            () => WeekDayPicker(
              context: mockContext,
              firstDate: today,
              initialDate: today,
              lastDate: today,
              selectableDayInWeek: [0],
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'All Assertion is passed',
        () {
          //

          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: today,
            initialDate: today,
            lastDate: today,
            selectableDayInWeek: [1],
          );
          //
          expect(wekPicker, const TypeMatcher<WeekDayPicker>());
        },
      );
      test(
        'Check initial value whene optional parameter not passed',
        () {
          //

          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, null);
          expect(wekPicker.selectableDayInWeek, null);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.and);
        },
      );
      test(
        'Check initial value whene only selectableDay is passed',
        () {
          //
          DateTime selectedDate1 = today.add(const Duration(days: 5));
          DateTime selectedDate2 = today.add(const Duration(days: 10));

          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
            selectableDay: [selectedDate1, selectedDate2],
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, [selectedDate1, selectedDate2]);
          expect(wekPicker.selectableDayInWeek, null);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.and);
        },
      );
      test(
        'Check initial value whene only selectableDayInWeek is passed',
        () {
          //
          List<int> selectableDayInWeek = [1, 5, 4];

          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
            selectableDayInWeek: selectableDayInWeek,
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, null);
          expect(wekPicker.selectableDayInWeek, selectableDayInWeek);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.and);
        },
      );
      test(
        'Check initial value whene only selectableBitwiseOperator is passed',
        () {
          //
          BitwiseOperator selectableBitwiseOperator = BitwiseOperator.or;

          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
            selectableBitwiseOperator: selectableBitwiseOperator,
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, null);
          expect(wekPicker.selectableDayInWeek, null);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.or);
        },
      );
      test(
        'Check initial value whene only selectableDayInWeek not passed',
        () {
          //
          BitwiseOperator selectableBitwiseOperator = BitwiseOperator.or;
          DateTime selectedDate1 = today.add(const Duration(days: 5));
          DateTime selectedDate2 = today.add(const Duration(days: 10));
          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
            selectableDay: [selectedDate1, selectedDate2],
            selectableBitwiseOperator: selectableBitwiseOperator,
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, [selectedDate1, selectedDate2]);
          expect(wekPicker.selectableDayInWeek, null);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.or);
        },
      );
      test(
        'Check initial value whene only selectableDay not passed',
        () {
          //
          BitwiseOperator selectableBitwiseOperator = BitwiseOperator.or;
          List<int> selectableDayInWeek = [1, 5, 4];
          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
            selectableDayInWeek: selectableDayInWeek,
            selectableBitwiseOperator: selectableBitwiseOperator,
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, null);
          expect(wekPicker.selectableDayInWeek, selectableDayInWeek);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.or);
        },
      );
      test(
        'Check initial value whene only selectableBitwiseOperator is not passed',
        () {
          //
          List<int> selectableDayInWeek = [1, 5, 4];
          DateTime selectedDate1 = today.add(const Duration(days: 5));
          DateTime selectedDate2 = today.add(const Duration(days: 10));
          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
            selectableDayInWeek: selectableDayInWeek,
            selectableDay: [selectedDate1, selectedDate2],
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, [selectedDate1, selectedDate2]);
          expect(wekPicker.selectableDayInWeek, selectableDayInWeek);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.and);
        },
      );
      test(
        'Check initial value whene all parameter is passed',
        () {
          //
          BitwiseOperator selectableBitwiseOperator = BitwiseOperator.or;
          List<int> selectableDayInWeek = [1, 5, 4];
          DateTime selectedDate1 = today.add(const Duration(days: 5));
          DateTime selectedDate2 = today.add(const Duration(days: 10));
          //
          var wekPicker = WeekDayPicker(
            context: mockContext,
            firstDate: firstDate,
            initialDate: today,
            lastDate: lastDate,
            selectableDayInWeek: selectableDayInWeek,
            selectableBitwiseOperator: selectableBitwiseOperator,
            selectableDay: [selectedDate1, selectedDate2],
          );
          //
          expect(wekPicker.firstDate, firstDate);
          expect(wekPicker.lastDate, lastDate);
          expect(wekPicker.initialDate, today);
          expect(wekPicker.selectableDay, [selectedDate1, selectedDate2]);
          expect(wekPicker.selectableDayInWeek, selectableDayInWeek);
          expect(wekPicker.selectableBitwiseOperator, BitwiseOperator.or);
        },
      );
    },
  );
}
