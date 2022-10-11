import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'widgets/footer_widgets.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final log = Logger('BottomWidget');
    // log.fine('build');
    return SizedBox(
      height: 50 * context.widgetSize.scale,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: const [
            NextWidget(),
            BottonsWidget(
              key: Key('Bottom_Widget_Key'),
            ),
          ],
        ),
      ),
    );
  }
}
