import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class PreviousWidget extends StatelessWidget {
  const PreviousWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final log = Logger('PreviousWidget');
    // log.fine('build');
    return ValueListenableBuilder<bool>(
      valueListenable: context.appState.isFirst,
      builder: (BuildContext context, bool value, _) {
        // log.fine('[ValueListenableBuilder] build');
        return IconButton(
          key: const Key('previousWeekKey'),
          onPressed: value
              ? null
              : () {
                  context.appState.previousWeek();
                },
          icon: Icon(
            Icons.keyboard_arrow_up_outlined,
            color: value ? context.color.disableColor : context.color.iconColor,
          ),
          tooltip: value
              ? null
              : MaterialLocalizations.of(context).previousPageTooltip,
        );
      },
    );
  }
}
