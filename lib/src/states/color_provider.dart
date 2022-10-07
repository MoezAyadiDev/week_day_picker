import 'package:flutter/cupertino.dart';

class ColorProvider extends InheritedWidget {
  final Color headerColor;
  final Color onHeaderColor;
  final Color iconColor;
  final Color disableColor;
  final Color selectedColor;
  final Color onSelectedColor;

  const ColorProvider({
    Key? key,
    required Widget child,
    required this.headerColor,
    required this.onHeaderColor,
    required this.iconColor,
    required this.selectedColor,
    required this.onSelectedColor,
    required this.disableColor,
  }) : super(
          key: key,
          child: child,
        );

  static ColorProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ColorProvider>()!;

  @override
  bool updateShouldNotify(ColorProvider oldWidget) => false;
}
