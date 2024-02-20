import 'package:flutter/cupertino.dart';
import 'package:week_day_picker/src/states/item_height.dart';

class SizeProvider extends InheritedWidget {
  final ItemHeight itemHeight;
  final double scale;

  const SizeProvider({
    super.key,
    required super.child,
    required this.itemHeight,
    required this.scale,
  });

  static SizeProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SizeProvider>()!;

  @override
  bool updateShouldNotify(SizeProvider oldWidget) => false;
}
