## Week Day Picker
The widget display a dialog contain the calandar on week mode.
Return a `Future<DateTime>` if the user select a date or `Future<null>` if the user cancel the dialog
<p><img src="https://raw.githubusercontent.com/MoezAyadiDev/week_day_picker/main/assets/weekdaypicker.gif"></P>

## Installation
Add `week_day_picker` to your `pubspec.yaml` as a dependacy
```yaml
dependencies:
  week_day_picker:0.0.1
```

## Usage
Import the package
```dart
import 'package:week_day_picker/week_day_picker.dart';
```

Create an instance of WeekDayPicker and invoke the show methode don't forget to await for response.
it return a Future<DateTime> if the user select a date or Future<null> if the user cancel the picker or clicked outsie

```dart
 var weekDayPicker = WeekDayPicker(
    context: context,
    firstDate: DateTime(2021, 1, 13),
    lastDate: DateTime(2023, 10, 19),
);
DateTime? selectedDate = await weekDayPicker.show();
```
Default current date is the system date, to change it use `currentDate` to highlight and show this date in first screen.
```dart
 var weekDayPicker = WeekDayPicker(
    context: context,
    firstDate: DateTime(2021),
    lastDate: DateTime(2023),
    currentDate : DateTime(2022, 10, 1),
);
```

Use `initialDate` to send the selected Date to the dailog.
Don't confuse it with current date the initialDate is the selected Date
```dart
 var weekDayPicker = WeekDayPicker(
    context: context,
    firstDate: DateTime(2021, 1, 13),
    lastDate: DateTime(2023, 10, 19),
    initialDate : DateTime(2022, 10, 1),
);
```
<p><img src="https://raw.githubusercontent.com/MoezAyadiDev/week_day_picker/main/assets/picker_selectedDate.gif"></P>


To send list of selectable date use `selectableDay`
```dart
WeekDayPicker(
    ...
  selectableDay: [
    DateTime(2022, 9, 12),
    DateTime(2022, 9, 21)
  ],
);
```

Or you can use `selectableDayInWeek` to display only specific day on week
begin by 
Monday : 1 
... 
Sunday : 7.
In this example the user can select only the date in Monday and Friday
```dart
WeekDayPicker(
    ...
  selectableDayInWeek: [1, 5],
);
```
<p><img src="https://raw.githubusercontent.com/MoezAyadiDev/week_day_picker/main/assets/picker_selectableDayWeek.gif"></P>


To combine `selectableDayInWeek` and `selectableDay` by default the picker use inner join. 
That meen that the allowed date must satisfy the two condition.
to provide outer join use the option `selectableBitwiseOperator`
it can be 
 - `BitwiseOperator.or` : Outer join
 - `BitwiseOperator.and` : Inner join
 ```dart
 var response = await WeekDayPicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2021, 1, 13),
    lastDate: DateTime(2023, 10, 19),
    selectableDay: [
        DateTime(2022, 9, 12),
        DateTime(2022, 9, 21)
    ],
    selectableDayInWeek: [1, 5],
    selectableBitwiseOperator: BitwiseOperator.or,
).show();
```

## Language
Bu passing the context th dialog use the application langugae 

## Theming
By default the dialog use default theme to change the theme color use is options :
- `colorHeader`: Background header
- `colorOnHeader` : Text header
- `colorIcon` : Icon color (previous and next week)
- `colorDisabled` : Text of not allowed date and icon color if the user rich the last or first week
- `colorSelected` : The background color of selected date
- `colorOnSelected` : The text color of selected date
    
    
## Additional information
for more information check the complete example
<p></p>
In case of problem please open an [issue](https://github.com/MoezAyadiDev/week_day_picker/issues/new?template=bug_report.md)