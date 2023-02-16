import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class SelectedDateWidget extends StatelessWidget {
  const SelectedDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final log = Logger('SelectedDateWidget');
    // log.fine('build');
    return Center(
      child: ValueListenableBuilder<DateTime?>(
        valueListenable: context.appState.selectedDate,
        builder: (BuildContext context, DateTime? value, Widget? child) {
          String textDate = (value != null)
              ? DateFormat('EEEE dd MMM yyyy').format(value).capitalize()
              : MaterialLocalizations.of(context).datePickerHelpText;
          return Text(
            textDate,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: context.color.onHeaderColor),
            overflow: TextOverflow.fade,
            maxLines: 2,
          );
        },
      ),
    );
  }
}
