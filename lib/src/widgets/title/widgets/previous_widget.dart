import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

class PreviousWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color disableColor;
  const PreviousWidget({
    super.key,
    required this.backgroundColor,
    required this.disableColor,
  });

  @override
  Widget build(BuildContext context) {
    final log = Logger('PreviousWidget');
    log.fine('build');
    return IconButton(
      onPressed: context.appState.isFirstWeek
          ? null
          : () {
              WeekDayWidget.of(context).previousWeek();
            },
      icon: Icon(
        Icons.keyboard_arrow_up_outlined,
        color: context.appState.isFirstWeek ? disableColor : backgroundColor,
      ),
    );
  }
}
