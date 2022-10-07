import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/widget_helper.dart';
import 'package:week_day_picker/src/states/color_provider.dart';
import 'package:week_day_picker/src/widgets/content/content_widget.dart';
import 'package:week_day_picker/src/widgets/footer/footer_widget.dart';
import 'package:week_day_picker/src/widgets/title/title_widget.dart';

class WeekDayWidget extends StatelessWidget {
  final Color? headerColor;
  final Color? onHeaderColor;
  final Color? iconColor;
  final Color? disableColor;
  final Color? selectedColor;
  final Color? onSelectedColor;
  final Color? backgroundColor;
  const WeekDayWidget({
    super.key,
    required this.headerColor,
    required this.onHeaderColor,
    required this.iconColor,
    required this.disableColor,
    required this.selectedColor,
    required this.onSelectedColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    var log = Logger('WeekDayWidget');
    log.fine('build');
    Size dialogSize = getSize(context);

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isDark = colorScheme.brightness == Brightness.dark;

    //Primary color
    final Color primaryColor =
        isDark ? colorScheme.surface : colorScheme.primary;
    final Color onPrimaryColor =
        isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    //Secondary color
    final Color secondaryColor = isDark
        //
        ? colorScheme.primary
        : colorScheme.primaryContainer;
    final Color onSecondaryColor = isDark
        //
        ? colorScheme.onPrimary
        : colorScheme.onPrimaryContainer;

    //Disabled color to show when Date is not valid
    final Color disableColors = isDark
        //
        ? colorScheme.surfaceVariant
        : colorScheme.surfaceVariant;

    final Color surfaceColor = isDark
        //
        ? colorScheme.onInverseSurface
        : colorScheme.surface;
    final Color onSurfaceColor = colorScheme.primary;

    //ColorProvider colorProvider = ColorProvider()
    //Title Widget
    const Widget titel = TitleWidget(key: Key('titleWidgetKey'));
    //Footer Widget
    const Widget footer = FooterWidget(key: Key('footerWidgetKey'));

    final contentWidget = ContentWidget(
      isDoublePadding: dialogSize.height == maxHeight,
    );

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: backgroundColor ?? surfaceColor,
      child: SingleChildScrollView(
        child: SizedBox(
          height: dialogSize.height,
          width: dialogSize.width,
          child: ColorProvider(
            headerColor: headerColor ?? primaryColor,
            onHeaderColor: onHeaderColor ?? onPrimaryColor,
            iconColor: iconColor ?? onSurfaceColor,
            selectedColor: selectedColor ?? secondaryColor,
            onSelectedColor: onSelectedColor ?? onSecondaryColor,
            disableColor: disableColor ?? disableColors,
            child: Column(
              children: [
                titel,
                contentWidget,
                footer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
