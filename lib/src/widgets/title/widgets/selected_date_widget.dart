import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class SelectedDateWidget extends StatelessWidget {
  final Color textColor;
  const SelectedDateWidget({
    super.key,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final log = Logger('SelectedDateWidget');
    log.fine('build');
    final String dateText = (context.appState.selectedDate != null)
        ? DateFormat('EEEE dd MMM yyyy')
            .format(context.appState.selectedDate!)
            .capitalize()
        : MaterialLocalizations.of(context).datePickerHelpText;
    return Center(
      child: Text(
        dateText,
        style:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: textColor),
        overflow: TextOverflow.fade,
        maxLines: 2,
      ),
    );
  }
}
