import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/widgets/bottom/widgets/widgets_bottom.dart';

class BottomWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color disableColor;
  const BottomWidget({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.disableColor,
  });

  @override
  Widget build(BuildContext context) {
    final log = Logger('BottomWidget');
    log.fine('build');
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            ForwardWidget(
              backgroundColor: backgroundColor,
              disableColor: disableColor,
            ),
            const BottonsWidget(
              key: Key('Bottom_Widget_Key'),
            ),
          ],
        ),
      ),
    );
  }
}
