import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

class MonthWidget extends StatefulWidget {
  final Color textColor;
  final Color backgroundColor;
  final MonthModel selectedMonth;
  final List<MonthModel> months;
  const MonthWidget({
    super.key,
    required this.textColor,
    required this.backgroundColor,
    required this.selectedMonth,
    required this.months,
  });

  @override
  State<MonthWidget> createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  late MonthModel drowdownvalue = widget.selectedMonth;
  final log = Logger('MonthWidget');
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    log.fine('didChangeDependencies');
    if (drowdownvalue != context.appState.month) {
      drowdownvalue = context.appState.month;
    }
  }

  @override
  Widget build(BuildContext context) {
    log.fine('build');
    return DropdownButtonHideUnderline(
      child: DropdownButton<MonthModel>(
        value: drowdownvalue,
        items: widget.months
            .map<DropdownMenuItem<MonthModel>>(
              (e) => DropdownMenuItem<MonthModel>(
                value: e,
                child: Text(
                  e.month,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              FocusScope.of(context).requestFocus(FocusNode());
              drowdownvalue = value;
              WeekDayWidget.of(context).setMouths(drowdownvalue);
            });
          }
        },
      ),
    );
  }
}
