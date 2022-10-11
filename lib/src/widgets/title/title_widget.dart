import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/month_list.dart';
import 'package:week_day_picker/src/widgets/title/widgets/title_widgets.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final log = Logger('TitleWidget');
    // log.fine('build');
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 50 * context.widgetSize.scale,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: context.color.headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: SelectedDateWidget(),
          ),
        ),
        SizedBox(
          height: 50 * context.widgetSize.scale,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const PreviousWidget(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const MonthWidget(),
                      const SizedBox(width: 10.0),
                      ValueListenableBuilder<MonthList>(
                        valueListenable: context.appState.months,
                        builder: (context, value, child) {
                          // log.fine('ValueListenableBuilder build');
                          return Container();
                        },
                      ),
                      const YearWidget(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
