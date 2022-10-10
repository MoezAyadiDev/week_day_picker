import 'package:flutter/cupertino.dart';
import 'package:week_day_picker/src/states/item_height.dart';

class SizeProvider extends InheritedWidget {
  final ItemHeight itemHeight;
  final double scale;

  const SizeProvider({
    Key? key,
    required Widget child,
    required this.itemHeight,
    required this.scale,
  }) : super(
          key: key,
          child: child,
        );

  static SizeProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SizeProvider>()!;

  @override
  bool updateShouldNotify(SizeProvider oldWidget) => false;
}
