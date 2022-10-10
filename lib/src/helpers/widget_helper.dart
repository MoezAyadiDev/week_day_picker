import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

const double maxHeight = 439;
const double minHeight = 360;

///Get the final dialog Size
///
///Titel size = 100
///
///bottom size = 60
///
///content size : min = 210, max = getSize - 160
Size getSize(BuildContext context, double scale) {
  Size size = MediaQuery.of(context).size;
  double width = min(250 * scale, size.width * scale - 40);
  double maxHeightW = size.height - 40;
  double height = (maxHeightW > (maxHeight * scale))
      ? (maxHeight * scale)
      : (minHeight * scale);

  return Size(width, height);
}

Function listEquality = const ListEquality().equals;

Widget widgetBuilder({required Widget child, required Size size}) {
  var log = Logger('widgetBuilder');
  log.fine('build : ${size.height}');
  if (size.height < minHeight) {
    log.fine('size.height < minHeight');
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: child,
      ),
    );
  } else {
    log.fine('size ok');
    return SizedBox(
      height: size.height,
      width: size.width,
      child: child,
    );
  }
}
