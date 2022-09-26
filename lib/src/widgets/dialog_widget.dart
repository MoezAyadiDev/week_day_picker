import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/helpers/widget_helper.dart';
import 'package:week_day_picker/src/widgets/bottom/bottom_widget.dart';
import 'package:week_day_picker/src/widgets/content/day_widget.dart';
import 'package:week_day_picker/src/widgets/title/title_widget.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger('DialogWidget');
    log.fine('build');
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isDark = colorScheme.brightness == Brightness.dark;
    //Primary color
    final Color primaryColor =
        isDark ? colorScheme.surface : colorScheme.primary;
    final Color onPrimaryColor =
        !isDark ? colorScheme.onPrimary : colorScheme.onSurface;

    //Secondary color
    final Color secondaryColor = isDark
        //
        ? colorScheme.surfaceVariant
        : colorScheme.primaryContainer;
    final Color onSecondaryColor = isDark
        //
        ? colorScheme.onSurfaceVariant
        : colorScheme.onPrimaryContainer;

    //Disabled color to show when Date is not valid
    final Color disableColor = isDark
        //
        ? colorScheme.surfaceVariant
        : colorScheme.surfaceVariant;
    //Title Widget
    final Widget titel = TitleWidget(
      backgroundColor: primaryColor,
      textColor: onPrimaryColor,
      disableColor: disableColor,
    );

    //Content Widget
    Size dialogSize = getSize(context);
    bool isDoublePadding = dialogSize.height == maxHeight;
    final contentWidget = DayWidget(
      isDoublePadding: isDoublePadding,
      secondaryColor: secondaryColor,
      onSecondaryColor: onSecondaryColor,
      primaryColor: primaryColor,
      days: context.appState.days,
      disableColor: disableColor,
    );

    //Bottom Widget
    final Widget bottomWidget = BottomWidget(
      backgroundColor: primaryColor,
      textColor: onPrimaryColor,
      disableColor: disableColor,
    );

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: SizedBox(
        width: dialogSize.width,
        height: dialogSize.height,
        child: Column(
          children: [
            titel,
            contentWidget,
            bottomWidget,
          ],
        ),
      ),
    );
  }
}
