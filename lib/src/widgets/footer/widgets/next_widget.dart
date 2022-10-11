import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class NextWidget extends StatelessWidget {
  const NextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final log = Logger('NextWidget');
    // log.fine('build');
    return ValueListenableBuilder<bool>(
      valueListenable: context.appState.isLast,
      builder: (BuildContext context, bool value, _) {
        // log.fine('[ValueListenableBuilder] value = $value');
        return IconButton(
          key: const Key('nextWeekKey'),
          onPressed: value
              ? null
              : () {
                  context.appState.nextWeek();
                },
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: value ? context.color.disableColor : context.color.iconColor,
          ),
          tooltip:
              value ? null : MaterialLocalizations.of(context).nextPageTooltip,
        );
      },
    );
  }
}
