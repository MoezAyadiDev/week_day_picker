import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week_day_picker/src/week_day_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> createWidget(
  WidgetTester tester,
  InitialValue initialValue,
  // DateTime firstDate,
  // DateTime lastDate,
) async {
  await tester.pumpWidget(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      locale: const Locale('en'),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  WeekDayPicker(
                    context: context,
                    firstDate: initialValue.firstDate,
                    lastDate: initialValue.lastDate,
                    initialDate: initialValue.initialDate,
                    currentDate: initialValue.currentDate,
                    selectableDay: initialValue.selectableDay,
                    selectableDayInWeek: initialValue.selectableDayInWeek,
                    selectableBitwiseOperator:
                        initialValue.selectableBitwiseOperator,
                  ).show();
                },
                child: const Text('Week day picker'),
              ),
            ),
          );
        },
      ),
    ),
  );

  await tester.pump();
}

class InitialValue {
  final DateTime? initialDate;
  final DateTime? currentDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<DateTime>? selectableDay;
  final List<int>? selectableDayInWeek;
  final BitwiseOperator selectableBitwiseOperator;
  final String type;

  const InitialValue({
    required this.firstDate,
    required this.lastDate,
    required this.type,
    this.initialDate,
    this.currentDate,
    this.selectableDay,
    this.selectableDayInWeek,
    this.selectableBitwiseOperator = BitwiseOperator.and,
  });

  @override
  String toString() {
    return type;
  }
}

var pickerBasic = InitialValue(
  firstDate: DateTime(2021, 6, 5),
  lastDate: DateTime(2023, 10, 5),
  type: 'Basic',
  currentDate: DateTime(2022, 10, 5),
);
var pickerInitValue = InitialValue(
  firstDate: DateTime(2021, 6, 5),
  lastDate: DateTime(2023, 9, 5),
  initialDate: DateTime(2022, 10, 4),
  type: 'Basic With initial Value',
  currentDate: DateTime(2022, 10, 5),
);
var pickerPreviousNextCheck = InitialValue(
  firstDate: DateTime(2022, 6, 5),
  lastDate: DateTime(2022, 6, 19),
  initialDate: DateTime(2022, 6, 9),
  type: 'Previous and Next week Check',
  currentDate: DateTime(2022, 10, 5),
);
var differentYear = InitialValue(
  firstDate: DateTime(2022, 6, 5),
  lastDate: DateTime(2023, 4, 19),
  initialDate: DateTime(2022, 12, 30),
  type: 'Diffirent year',
  currentDate: DateTime(2022, 10, 5),
);
final basicValue = ValueVariant<InitialValue>({
  pickerBasic,
  pickerInitValue,
  pickerPreviousNextCheck,
  differentYear,
});

String getDropDownValue(WidgetTester tester, String key) {
  String result = 'Null';
  var myFinder = find.byKey(Key(key));
  if (myFinder.evaluate().isNotEmpty) {
    var resultWidget = tester.widget<DropdownButton>(myFinder);
    result = resultWidget.value.toString();
  }
  return result;
}
