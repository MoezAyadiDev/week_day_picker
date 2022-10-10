import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/widgets/content/widgets/days_widget.dart';

enum AnimationSense { none, previous, forward }

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger('ContentWidget');
    log.fine('build');

    return ValueListenableBuilder<double>(
        valueListenable: context.widgetSize.itemHeight.height,
        builder: (context, value, child) {
          double height = value;
          bool isDoublePadding = context.widgetSize.itemHeight.isDoublePadding;
          return ValueListenableBuilder<List<DayModel>>(
            valueListenable: context.appState.days,
            builder: (context, value, child) {
              return SizedBox(
                height: height * 7,
                child: DaysWidget(
                  days: value,
                  height: height,
                  isDoublePadding: isDoublePadding,
                ),
              );
            },
          );
        });
  }
}
