import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/widgets/content/item_widget.dart';

import 'helper/widget_helper.dart';

void main() {
  late DateTime today;
  setUp(() {
    today = DateTime.now();
  });
  testWidgets(
    'Testing Widget Helper',
    (WidgetTester tester) async {
      var myWidget = const MyWidgetTest();
      await tester.pumpWidget(myWidget);
      expect(
        find.text('Week day picker'),
        findsOneWidget,
        reason: 'Cheeck the widget is pump with no error',
      );
    },
  );
  testWidgets(
    'Testing all Dialog DateTime picker composant',
    (WidgetTester tester) async {
      //
      var myWidget = const MaterialApp(home: MyWidgetTest());
      //
      await tester.pumpWidget(myWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      //
      expect(
        find.byType(TextButton),
        findsNWidgets(2),
        reason: '2 Text Button Ok and Annuler',
      );
      expect(
        find.byType(DropdownButton<MonthModel>),
        findsOneWidget,
        reason: 'Only 1 Month Dropdown ',
      );
      expect(
        find.byType(DropdownButton<int>),
        findsOneWidget,
        reason: 'Only 1 year Dropdown ',
      );
      expect(
        find.byType(IconButton),
        findsNWidgets(2),
        reason: '2 IconButton Previous and Next week',
      );
      expect(
        find.byType(ItemWidget),
        findsNWidgets(7),
        reason: '7 day in list',
      );
      expect(
        find.byType(ItemWidget),
        findsNWidgets(7),
        reason: '7 day in list',
      );

      expect(
        find.text(
          DateFormat('EEEE dd MMM yyyy').format(today).capitalize(),
        ),
        findsOneWidget,
      );
    },
  );
}
