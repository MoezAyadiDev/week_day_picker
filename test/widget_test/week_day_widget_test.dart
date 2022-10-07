import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/widgets/content/widgets/item_widget.dart';
import 'helper/day_helper.dart';
import 'helper/month_helper.dart';
import 'helper/widget_helper.dart';
import 'helper/year_helper.dart';

const Key _nextWeekKey = Key('nextWeekKey');
const Key _previousWeekKey = Key('previousWeekKey');
const String _monthSelected = 'MonthModelDropdownKey';
const String _yearSelected = 'intDropdownKey';

const String _nextPageTooltip = 'Next page';
const String _previousPageTooltip = 'Previous page';

void main() {
  testWidgets(
    '[Testing initial value]',
    (WidgetTester tester) async {
      // group('Initial value', body)
      //
      final current = basicValue.currentValue!;
      var monthHelper = MonthHelper(current);
      var yearHelper = YearHelper(current);
      var dayHelper = DayHelper(current);

      await createWidget(
        tester,
        current,
      );
      await tester.pump();
      expect(find.text('Week day picker'), findsOneWidget);
      expect(
        find.byType(ElevatedButton),
        findsNWidgets(1),
        reason: 'Week day picker Button to show Picker',
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Find Widget
      //Selected Date
      expect(
        find.text(
          (current.initialDate == null)
              ? 'SELECT DATE'
              : DateFormat('EEEE dd MMM yyyy')
                  .format(current.initialDate!)
                  .capitalize(),
        ),
        findsOneWidget,
      );
      //Next and Previous week
      expect(
        find.byType(IconButton),
        findsNWidgets(2),
        reason: '2 IconButton Previous and Next week',
      );

      //Month
      expect(
        find.byType(DropdownButton<MonthModel>),
        findsOneWidget,
        reason: 'Only 1 Month Dropdown ',
      );

      expect(
        find.text(monthHelper.initialValue()),
        findsOneWidget,
        reason: 'the month initial value',
      );

      //Year
      expect(
        find.byType(DropdownButton<int>),
        findsOneWidget,
        reason: 'Only 1 year Dropdown ',
      );

      expect(
        find.text(yearHelper.initialValue()),
        findsOneWidget,
        reason: 'the year initial value',
      );
      //Days
      expect(
        find.byType(ItemWidget),
        findsNWidgets(7),
        reason: '7 days displayes ',
      );
      List<String> days = dayHelper.initialValue();
      for (var day in days) {
        expect(
          find.byKey(Key(day)),
          findsOneWidget,
          reason: 'the first day initial value',
        );
      }

      // expect(
      //   find.byType(TextButton),
      //   findsNWidgets(2),
      //   reason: '2 Text Button Ok and Annuler',
      // );

      // expect(
      //   find.byType(DropdownButton<int>),
      //   findsOneWidget,
      //   reason: 'Only 1 year Dropdown ',
      // );
      // expect(
      //   find.byType(IconButton),
      //   findsNWidgets(2),
      //   reason: '2 IconButton Previous and Next week',
      // );
      // expect(
      //   find.byType(ItemWidget),
      //   findsNWidgets(7),
      //   reason: '7 day in list',
      // );
      // expect(
      //   find.byType(ItemWidget),
      //   findsNWidgets(7),
      //   reason: '7 day in list',
      // );
    },
    variant: basicValue,
  );

  testWidgets(
    '[Previous and next week]',
    (WidgetTester tester) async {
      final current = basicValue.currentValue!;
      var monthHelper = MonthHelper(current);
      var yearHelper = YearHelper(current);
      var dayHelper = DayHelper(current);
      await createWidget(
        tester,
        current,
      );
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      Finder nextButtonFinder = find.byKey(_nextWeekKey);
      Finder previousButtonFinder = find.byKey(_previousWeekKey);
      expect(nextButtonFinder, findsOneWidget);
      expect(find.byTooltip(_nextPageTooltip), findsOneWidget);
      expect(previousButtonFinder, findsOneWidget);
      expect(find.byTooltip(_previousPageTooltip), findsOneWidget);

      //Month
      expect(
        getDropDownValue(tester, _monthSelected),
        monthHelper.initialValue(),
        reason: 'the month initial value',
      );
      //Year
      expect(
        getDropDownValue(tester, _yearSelected),
        yearHelper.initialValue(),
        reason: 'the year initial value',
      );

//----------------------------------------------------------------
//                          Next Week
//----------------------------------------------------------------
      await tester.tap(nextButtonFinder);
      await tester.pump();

      //Next And Previous Button
      expect(
        find.byTooltip(_nextPageTooltip),
        current.type != 'Previous and Next week Check'
            ? findsOneWidget
            : findsNothing,
      );
      expect(find.byTooltip(_previousPageTooltip), findsOneWidget);

      //Month Widget
      expect(
        getDropDownValue(tester, _monthSelected),
        monthHelper.nextWeek(),
        reason: 'the month next week',
      );
      //Year Widget
      expect(
        getDropDownValue(tester, _yearSelected),
        yearHelper.nextWeek(),
        reason: 'the year next week',
      );
      //Day Widget
      List<String> days = dayHelper.nextWeek();
      for (var day in days) {
        expect(
          find.byKey(Key(day)),
          findsOneWidget,
          reason: 'the first day initial value',
        );
      }
//----------------------------------------------------------------
//                          Previous Week
//----------------------------------------------------------------
      await tester.tap(previousButtonFinder);
      await tester.pump();
      //Month Widget
      expect(
        getDropDownValue(tester, _monthSelected),
        monthHelper.initialValue(),
        reason: 'the month initial value',
      );
      //Year Widget
      expect(
        getDropDownValue(tester, _yearSelected),
        yearHelper.initialValue(),
        reason: 'the year initial value',
      );
      //Day Widget
      days = dayHelper.initialValue();
      for (var day in days) {
        expect(
          find.byKey(Key(day)),
          findsOneWidget,
          reason: 'the first day initial value',
        );
      }

//----------------------------------------------------------------
//                          Previous Week
//----------------------------------------------------------------
      await tester.tap(previousButtonFinder);
      await tester.pump();
      //Previous Week
      expect(
        find.byTooltip(_previousPageTooltip),
        current.type != 'Previous and Next week Check'
            ? findsOneWidget
            : findsNothing,
      );
      expect(find.byTooltip(_nextPageTooltip), findsOneWidget);

      //Month Widget
      expect(
        getDropDownValue(tester, _monthSelected),
        monthHelper.previousWeek(),
        reason: 'the month previous value',
      );
      //Year Widget
      expect(
        getDropDownValue(tester, _yearSelected),
        yearHelper.previousWeek(),
        reason: 'the year previous value',
      );
      //Day Widget
      days = dayHelper.lastWeek();
      for (var day in days) {
        expect(
          find.byKey(Key(day)),
          findsOneWidget,
          reason: 'the first day initial value',
        );
      }
    },
    variant: basicValue,
  );

  testWidgets(
    '[Year changed]',
    (WidgetTester tester) async {
      final current = basicValue.currentValue!;

      var monthHelper = MonthHelper(current);
      var yearHelper = YearHelper(current);
      // var dayHelper = DayHelper(current);
      await createWidget(
        tester,
        current,
      );
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      //Change the year
      final dropdown = find.byKey(const ValueKey(_yearSelected));
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      final dropdownItem = find.text(yearHelper.changeYear()).last;

      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      //Year Widget
      expect(
        getDropDownValue(tester, _yearSelected),
        yearHelper.changeYear(),
        reason: 'the year was changed',
      );
      //Month Widget
      expect(
        getDropDownValue(tester, _monthSelected),
        monthHelper.yearChanged(),
        reason: 'Display correct month when the year was changed',
      );
    },
    variant: basicValue,
  );

  testWidgets(
    '[Month changed]',
    (WidgetTester tester) async {
      final current = basicValue.currentValue!;

      var monthHelper = MonthHelper(current);
      var yearHelper = YearHelper(current);

      await createWidget(
        tester,
        current,
      );
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      //Change the year
      final dropdown = find.byKey(const ValueKey(_monthSelected));
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      final dropdownItem = find.text(monthHelper.changeMonth()).last;
      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      //Year Widget
      expect(
        getDropDownValue(tester, _yearSelected),
        yearHelper.initialValue(),
        reason: 'the year must be the same',
      );
      //Month Widget
      expect(
        getDropDownValue(tester, _monthSelected),
        monthHelper.monthChanged(),
        reason: 'Display correct month when the month is changed',
      );
    },
    variant: basicValue,
  );
}
