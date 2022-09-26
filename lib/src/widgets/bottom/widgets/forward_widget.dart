import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

class ForwardWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color disableColor;
  const ForwardWidget({
    super.key,
    required this.backgroundColor,
    required this.disableColor,
  });

  @override
  Widget build(BuildContext context) {
    final log = Logger('ForwardWidget');
    log.fine('build');
    return IconButton(
      onPressed: context.appState.isLastWeek
          ? null
          : () {
              WeekDayWidget.of(context).nextWeek();
            },
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: context.appState.isLastWeek ? disableColor : backgroundColor,
      ),
    );
  }
}
