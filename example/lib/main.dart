import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:week_day_picker/week_day_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week day picker Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00b266),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00b266),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Week day picker Demo'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('ar', ''),
        Locale('es', ''),
        Locale('de', ''),
        Locale('it', ''),
      ],
      locale: const Locale('en'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              (selectedDate != null)
                  ? 'Selected Date : ${selectedDate.toString().substring(0, 10)}'
                  : 'Select a date',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await WeekDayPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021, 1, 13),
                  lastDate: DateTime(2023, 10, 19),
                ).show();
                setState(() {
                  selectedDate = response;
                });
              },
              child: const Text('Simple Week Day'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await WeekDayPicker(
                  context: context,
                  //initialDate: DateTime.now(),
                  firstDate: DateTime(2021, 1, 13),
                  lastDate: DateTime(2023, 10, 19),
                  selectableDayInWeek: [1, 5],
                ).show();
                setState(() {
                  selectedDate = response;
                });
              },
              child: const Text('Selectable Day of week'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await WeekDayPicker(
                  context: context,
                  //initialDate: DateTime.now(),
                  firstDate: DateTime(2021, 1, 13),
                  lastDate: DateTime(2023, 10, 19),
                  selectableDay: [DateTime(2022, 9, 12), DateTime(2022, 9, 21)],
                ).show();
                setState(() {
                  selectedDate = response;
                });
              },
              child: const Text('Selectable Day'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await WeekDayPicker(
                  context: context,
                  //initialDate: DateTime.now(),
                  firstDate: DateTime(2021, 1, 13),
                  lastDate: DateTime(2023, 10, 19),
                  selectableDay: [DateTime(2022, 9, 12), DateTime(2022, 9, 21)],
                  selectableDayInWeek: [1, 5],
                ).show();
                setState(() {
                  selectedDate = response;
                });
              },
              child: const Text('Mix Selectable with And (only 12/09)'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await WeekDayPicker(
                  context: context,
                  //initialDate: DateTime.now(),
                  firstDate: DateTime(2021, 1, 13),
                  lastDate: DateTime(2023, 10, 19),
                  selectableDay: [DateTime(2022, 9, 12), DateTime(2022, 9, 21)],
                  selectableDayInWeek: [1, 5],
                  selectableBitwiseOperator: BitwiseOperator.or,
                ).show();
                setState(() {
                  selectedDate = response;
                });
              },
              child: const Text('Mix Selectable with Or'),
            ),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2021),
                );
              },
              child: const Text('normal dateTimePicker'),
            ),
          ],
        ),
      ),
    );
  }
}
