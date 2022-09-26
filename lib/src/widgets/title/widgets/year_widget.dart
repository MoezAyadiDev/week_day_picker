import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

class YearWidget extends StatefulWidget {
  final Color textColor;
  final int selectedYear;
  final List<int> years;
  const YearWidget({
    super.key,
    required this.textColor,
    required this.selectedYear,
    required this.years,
  });

  @override
  State<YearWidget> createState() => _YearWidgetState();
}

class _YearWidgetState extends State<YearWidget> {
  late int drowdownvalue = widget.selectedYear;
  final log = Logger('YearWidget');

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    log.fine('didChangeDependencies');
    if (drowdownvalue != context.appState.year) {
      drowdownvalue = context.appState.year;
    }
  }

  @override
  Widget build(BuildContext context) {
    log.fine('build');
    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        value: drowdownvalue,
        items: widget.years
            .map<DropdownMenuItem<int>>((e) => DropdownMenuItem<int>(
                  value: e,
                  child: Text(
                    DateFormat("yyyy").format(DateTime(e)),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              FocusScope.of(context).requestFocus(FocusNode());
              drowdownvalue = value;
              WeekDayWidget.of(context).setYear(drowdownvalue);
            });
          }
        },
      ),
    );
  }
}
