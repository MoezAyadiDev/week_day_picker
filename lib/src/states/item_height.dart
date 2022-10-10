import 'package:flutter/widgets.dart';
import 'package:week_day_picker/src/helpers/widget_helper.dart';

class ItemHeight {
  ValueNotifier<double> height;
  bool isDoublePadding;
  Size widgetSize;

  ItemHeight({
    required double height,
    required this.isDoublePadding,
    required this.widgetSize,
  }) : height = ValueNotifier(height);

  setwidgetSize(newSize, scale) {
    widgetSize = newSize;
    isDoublePadding = widgetSize.height == maxHeight * scale;
    height.value = (isDoublePadding) ? 40.0 * scale : 30.0 * scale;
  }
}
