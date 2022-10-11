import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_list.dart';
import 'package:week_day_picker/src/models/month_model.dart';
import 'package:week_day_picker/src/widgets/commen/dropdown_widget.dart';

class MonthWidget extends StatelessWidget {
  const MonthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final log = Logger('MonthWidget');
    // log.fine('build');

    return ValueListenableBuilder<MonthList>(
      valueListenable: context.appState.months,
      builder: (context, value, child) {
        // log.fine('ValueListenableBuilder $value');
        return DropDownWidget<MonthModel>(
          key: const Key('monthListKey'),
          list: value.months,
          selectedValue: value.month,
          callBack: (MonthModel newValue) {
            context.appState.selectedMonthChanged(newValue);
          },
        );
      },
    );
  }
}
