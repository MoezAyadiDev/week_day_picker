import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class BottonsWidget extends StatelessWidget {
  const BottonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger('BottonsWidget');
    log.fine('build');
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: context.appState.selectedDate != null
                ? () => Navigator.of(context).pop(context.appState.selectedDate)
                : null,
            child: Text(
              MaterialLocalizations.of(context).okButtonLabel,
            ),
          ),
          const SizedBox(width: 10.0),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              MaterialLocalizations.of(context).cancelButtonLabel,
            ),
          ),
        ],
      ),
    );
  }
}
