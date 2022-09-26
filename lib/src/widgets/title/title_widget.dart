import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/widgets/title/widgets/widgets_title.dart';

class TitleWidget extends StatelessWidget {
  /// The latest allowable [DateTime] that the user can select.
  final Color backgroundColor;

  /// The latest allowable [DateTime] that the user can select.
  final Color textColor;
  final Color disableColor;

  const TitleWidget({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.disableColor,
  });

  @override
  Widget build(BuildContext context) {
    final log = Logger('TitleWidget');
    log.fine('build');
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SelectedDateWidget(
              textColor: textColor,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                PreviousWidget(
                  backgroundColor: backgroundColor,
                  disableColor: disableColor,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MonthWidget(
                        textColor: textColor,
                        backgroundColor: backgroundColor,
                        selectedMonth: context.appState.month,
                        months: context.appState.months,
                      ),
                      const SizedBox(width: 10.0),
                      YearWidget(
                        textColor: textColor,
                        selectedYear: context.appState.year,
                        years: context.appState.years,
                      ),
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
