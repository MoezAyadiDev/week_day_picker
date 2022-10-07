import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:week_day_picker/week_day_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode theme;

  @override
  void initState() {
    super.initState();
    theme = ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week day picker Demo',
      themeMode: theme,
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
      home: MyHomePage(
        title: 'Week day picker Demo',
        isDark: theme == ThemeMode.dark,
        callback: () {
          setState(() {
            theme =
                (theme == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
          });
        },
      ),
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
  final bool isDark;
  final VoidCallback callback;
  const MyHomePage({
    super.key,
    required this.title,
    required this.isDark,
    required this.callback,
  });

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
        actions: [
          IconButton(
            icon: Icon(widget.isDark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded),
            tooltip: 'Theme',
            onPressed: widget.callback,
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                (selectedDate != null)
                    ? 'Selected Date : ${selectedDate.toString().substring(0, 10)}'
                    : 'Select a date',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var dayWeekPicker = WeekDayPicker(
                    context: context,
                    firstDate: DateTime.now().add(const Duration(days: -500)),
                    lastDate: DateTime.now().add(const Duration(days: 500)),
                  );
                  var response = await dayWeekPicker.show();
                  setState(() {
                    selectedDate = response;
                  });
                },
                child: const Text('Simple Week Day'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var response = await WeekDayPicker(
                    context: context,
                    firstDate: DateTime(2022, 10, 1),
                    lastDate: DateTime(2022, 10, 31),
                    currentDate: DateTime(2022, 10, 24),
                    selectableDayInWeek: [1, 5], //Active Date: Monday & Friday
                  ).show();
                  setState(() {
                    selectedDate = response;
                  });
                },
                child: const Text('Selectable Day of week'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var response = await WeekDayPicker(
                    context: context,
                    firstDate: DateTime(2022, 10, 1),
                    lastDate: DateTime(2022, 10, 31),
                    currentDate: DateTime(2022, 10, 19),
                    selectableDay: [
                      DateTime(2022, 10, 5),
                      DateTime(2022, 10, 14),
                      DateTime(2022, 10, 17),
                      DateTime(2022, 10, 21),
                      DateTime(2022, 10, 25),
                      DateTime(2022, 10, 26),
                      DateTime(2022, 10, 27),
                    ],
                  ).show();
                  setState(() {
                    selectedDate = response;
                  });
                },
                child: const Text('Selectable Day'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var response = await WeekDayPicker(
                    context: context,
                    firstDate: DateTime(2022, 10, 1),
                    lastDate: DateTime(2022, 10, 31),
                    currentDate: DateTime(2022, 10, 19),
                    selectableDay: [
                      DateTime(2022, 10, 5),
                      DateTime(2022, 10, 14), //Active Date
                      DateTime(2022, 10, 17), //Active Date
                      DateTime(2022, 10, 21), //Active Date
                      DateTime(2022, 10, 25),
                      DateTime(2022, 10, 26),
                      DateTime(2022, 10, 27),
                    ],
                    selectableDayInWeek: [1, 5],
                  ).show();
                  setState(() {
                    selectedDate = response;
                  });
                },
                child: const Text('Two Selectable Inner Join'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  WeekDayPicker(
                    context: context,
                    firstDate: DateTime(2021, 1, 13),
                    lastDate: DateTime(2023, 10, 19),
                    currentDate: DateTime(2022, 10, 1),
                    initialDate: DateTime(2022, 10, 11),
                    selectableDay: [
                      DateTime(2022, 9, 12),
                      DateTime(2022, 9, 21)
                    ],
                    selectableDayInWeek: [1, 5],
                    selectableBitwiseOperator: BitwiseOperator.or,
                  );

                  var response = await WeekDayPicker(
                    context: context,
                    //initialDate: DateTime.now(),
                    firstDate: DateTime(2021, 1, 13),
                    lastDate: DateTime(2023, 10, 19),
                    selectableDay: [
                      DateTime(2022, 9, 12),
                      DateTime(2022, 9, 21)
                    ],
                    selectableDayInWeek: [1, 5],
                    selectableBitwiseOperator: BitwiseOperator.or,
                  ).show();
                  setState(() {
                    selectedDate = response;
                  });
                },
                child: const Text('Two Selectable Outer Join'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var dayWeekPicker = WeekDayPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    currentDate: DateTime.now().add(const Duration(days: -3)),
                    firstDate: DateTime(2021, 10, 1),
                    lastDate: DateTime(2023, 10, 19),
                    colorHeader: Colors.blue[700],
                    colorOnHeader: Colors.blue[100],
                    colorIcon: Colors.blueAccent[200],
                    colorDisabled: Colors.blueGrey[100],
                    colorSelected: Colors.blue[800],
                    colorOnSelected: Colors.lightBlue[100],
                  );
                  var response = await dayWeekPicker.show();
                  setState(() {
                    selectedDate = response;
                  });
                },
                child: const Text('Custom Color'),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
