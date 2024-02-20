import 'package:flutter/cupertino.dart';

class ColorProvider extends InheritedWidget {
  final Color headerColor;
  final Color onHeaderColor;
  final Color iconColor;
  final Color disableColor;
  final Color selectedColor;
  final Color onSelectedColor;
  const ColorProvider({
    super.key,
    required super.child,
    required this.headerColor,
    required this.onHeaderColor,
    required this.iconColor,
    required this.selectedColor,
    required this.onSelectedColor,
    required this.disableColor,
  });

  static ColorProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ColorProvider>()!;

  @override
  bool updateShouldNotify(ColorProvider oldWidget) => false;
}
