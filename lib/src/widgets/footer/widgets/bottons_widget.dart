import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';

class BottonsWidget extends StatelessWidget {
  const BottonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final log = Logger('BottonsWidget');
    // log.fine('build');
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ValueListenableBuilder<DateTime?>(
            valueListenable: context.appState.selectedDate,
            builder: (context, value, _) {
              return TextButton(
                onPressed: value != null
                    ? () => Navigator.of(context).pop(value)
                    : null,
                child: Text(
                  MaterialLocalizations.of(context).okButtonLabel,
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: value != null
                            ? context.color.iconColor
                            : context.color.disableColor,
                      ),
                ),
              );
            },
          ),
          const SizedBox(width: 10.0),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              MaterialLocalizations.of(context).cancelButtonLabel,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: context.color.iconColor),
            ),
          ),
        ],
      ),
    );
  }
}
