import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/widgets/content/widgets/days_widget.dart';

enum AnimationSense { none, previous, forward }

class ContentWidget extends StatelessWidget {
  final bool isDoublePadding;

  const ContentWidget({
    super.key,
    required this.isDoublePadding,
  });

  @override
  Widget build(BuildContext context) {
    final log = Logger('ContentWidget');
    log.info('build');
    double height = isDoublePadding ? 40 : 30;
    return ValueListenableBuilder<List<DayModel>>(
      valueListenable: context.appState.days,
      builder: (context, value, child) {
        log.info('ValueListenableBuilder $value');
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
  }
}
