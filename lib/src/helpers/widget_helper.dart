import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

const double maxHeight = 439;
const double minHeight = 360;

///Get the final dialog Size
///
///Titel size = 100
///
///bottom size = 60
///
///content size : min = 210, max = getSize - 160
Size getSize(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  double width = min(250, size.width - 40);
  double maxHeightW = size.height - 40;
  double height = (maxHeightW > maxHeight) ? maxHeight : minHeight;
  // : (maxHeightW > minHeight)
  //     ? minHeight
  //     : maxHeight;

  return Size(width, height);
}

Function egalite = const ListEquality().equals;
