import 'package:flutter/material.dart';
import 'package:week_day_picker/week_day_picker.dart';

void main() {
  runApp(const ExampleWidget());
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week day picker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 44, 92, 164),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeExample(),
    );
  }
}

class HomeExample extends StatefulWidget {
  const HomeExample({super.key});

  @override
  State<HomeExample> createState() => _HomeExampleState();
}

class _HomeExampleState extends State<HomeExample> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week day picker exmple')),
      body: Center(
        child: Column(
          children: [
            Text(
              (selectedDate != null)
                  ? 'Selected Date : ${selectedDate.toString().substring(0, 10)}'
                  : 'Select a date',
            ),
            ElevatedButton(
              onPressed: showWeekPicker,
              child: const Text('Select Date'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showWeekPicker() async {
    var response = await WeekDayPicker(
      context: context,
      firstDate: DateTime.now().add(const Duration(days: -356)),
      lastDate: DateTime.now().add(const Duration(days: 356)),
      currentDate: DateTime.now().add(const Duration(days: 1)),
      initialDate: DateTime.now().add(const Duration(days: 2)),
      selectableDayInWeek: [1, 4],
      selectableDay: [
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 3)),
      ],
      selectableBitwiseOperator: BitwiseOperator.and,
      locale: const Locale('fr', ''),
      colorHeader: Colors.blue[700],
      colorOnHeader: Colors.blue[100],
      colorIcon: Colors.blueAccent[200],
      colorDisabled: Colors.blueGrey[100],
      colorSelected: Colors.blue[800],
      colorOnSelected: Colors.lightBlue[100],
      backgroundColor: Colors.white,
    ).show();
    setState(() {
      selectedDate = response;
    });
  }
}
