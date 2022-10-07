import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/widgets/commen/dropdown_widget.dart';

class YearWidget extends StatelessWidget {
  const YearWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger('YearWidget');
    log.info('build');
    return ValueListenableBuilder<int>(
      valueListenable: context.appState.year,
      builder: (context, value, child) {
        log.info('ValueListenableBuilder $value');
        return DropDownWidget<int>(
          key: const Key('yearListKey'),
          list: context.appState.years,
          selectedValue: value,
          callBack: (int newValue) {
            context.appState.selectedYearChanged(newValue);
          },
        );
      },
    );
  }
}
