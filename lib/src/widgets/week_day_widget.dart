import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/widget_helper.dart';
import 'package:week_day_picker/src/states/color_provider.dart';
import 'package:week_day_picker/src/states/item_height.dart';
import 'package:week_day_picker/src/states/size_provider.dart';
import 'package:week_day_picker/src/widgets/content/content_widget.dart';
import 'package:week_day_picker/src/widgets/footer/footer_widget.dart';
import 'package:week_day_picker/src/widgets/title/title_widget.dart';
// import 'dart:io' show Platform;

enum TargerPlatform { normal, double }

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
    // var log = Logger('WeekDayWidget');
    // log.fine('build');

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
        ? colorScheme.outline
        : colorScheme.outlineVariant;

    final Color surfaceColor = isDark
        //
        ? colorScheme.onInverseSurface
        : colorScheme.surface;
    final Color onSurfaceColor = colorScheme.primary;
    ItemHeight itemHeight = ItemHeight(
      height: 40,
      isDoublePadding: true,
      widgetSize: const Size(400.0, 200.0),
    );
    //Scale
    TargerPlatform target;
    TargetPlatform plt = Theme.of(context).platform;

    if (kIsWeb) {
      target = TargerPlatform.normal;
    } else if (plt == TargetPlatform.linux) {
      target = TargerPlatform.normal;
    } else if (plt == TargetPlatform.macOS) {
      target = TargerPlatform.normal;
    } else if (plt == TargetPlatform.windows) {
      target = TargerPlatform.normal;
    } else {
      target = TargerPlatform.double;
    }
    double scale = (target == TargerPlatform.normal ? 1 : 1.2);

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: backgroundColor ?? surfaceColor,
      child: ColorProvider(
        headerColor: headerColor ?? primaryColor,
        onHeaderColor: onHeaderColor ?? onPrimaryColor,
        iconColor: iconColor ?? onSurfaceColor,
        selectedColor: selectedColor ?? secondaryColor,
        onSelectedColor: onSelectedColor ?? onSecondaryColor,
        disableColor: disableColor ?? disableColors,
        child: SizeProvider(
          itemHeight: itemHeight,
          scale: scale,
          child: Builder(builder: (context) {
            Size dialogSize = getSize(context, scale);

            const contentWidget = ContentWidget();
            itemHeight.setwidgetSize(dialogSize, scale);

            //Title Widget
            const Widget titel = TitleWidget(key: Key('titleWidgetKey'));
            //Footer Widget
            const Widget footer = FooterWidget(key: Key('footerWidgetKey'));
            return SingleChildScrollView(
              child: SizedBox(
                height: dialogSize.height,
                width: dialogSize.width,
                child: const Column(
                  children: [
                    titel,
                    contentWidget,
                    footer,
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
