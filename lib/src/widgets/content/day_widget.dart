import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/helpers/widget_helper.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/widgets/content/item_widget.dart';

enum AnimationSense { none, previous, forward }

class DayWidget extends StatefulWidget {
  final bool isDoublePadding;
  final Color secondaryColor;
  final Color onSecondaryColor;
  final Color primaryColor;
  final List<DayModel> days;
  final Color disableColor;
  const DayWidget({
    super.key,
    required this.isDoublePadding,
    required this.secondaryColor,
    required this.onSecondaryColor,
    required this.primaryColor,
    required this.days,
    required this.disableColor,
  });

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget>
    with SingleTickerProviderStateMixin {
  late List<DayModel> days;
  double height = 40;
  late AnimationController animationController;
  late Animation positionAnimation;
  List<double> finalPosition = [];
  AnimationSense animationSense = AnimationSense.none;
  final log = Logger('DayWidget');

  @override
  void initState() {
    super.initState();
    log.fine('initState');
    days = widget.days;
    height = widget.isDoublePadding ? 40 : 30;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    positionAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    )..addListener(
        () {
          if (animationSense == AnimationSense.previous) {
            finalPosition = setPreviousPosition(7);
          } else {
            finalPosition = setForwardPosition(7);
          }

          if (positionAnimation.isCompleted) {
            if (animationSense == AnimationSense.previous) {
              days.removeRange(7, 14);
              finalPosition = setPosition();
              animationSense = AnimationSense.none;
            } else if (animationSense == AnimationSense.forward) {
              days.removeRange(0, 7);
              finalPosition = setPosition();
              animationSense = AnimationSense.none;
            }
          }
        },
      );
    finalPosition = setPosition();
  }

  @override
  void didUpdateWidget(covariant DayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    log.fine('didUpdateWidget');
    double newHeight = widget.isDoublePadding ? 40 : 30;
    if (height != newHeight) {
      height = newHeight;
      finalPosition = setPosition();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    log.fine('didChangeDependencies');
    if (!egalite(days, context.appState.days)) {
      if (animationSense != AnimationSense.none) {
        if (animationSense == AnimationSense.previous) {
          days.removeRange(7, 14);
          finalPosition = setPosition();
          animationSense = AnimationSense.none;
        } else {
          days.removeRange(0, 7);
          finalPosition = setPosition();
          animationSense = AnimationSense.none;
        }
      }
      if (days[0].day.isAfter(context.appState.days[0].day)) {
        // for (var element in context.appState.days) {
        //   print('day = $element, isAllowed ${element.isAllowed}');
        // }

        previous();
      } else {
        // for (var element in context.appState.days) {
        //   print('day = $element, isAllowed ${element.isAllowed}');
        // }
        forward();
      }
    }
  }

  List<double> setPosition() {
    log.fine('setPosition');
    List<double> tempPosition = [];
    for (int i = 0; i < 7; i++) {
      tempPosition.add(height * i);
    }
    return tempPosition;
  }

  previous() {
    log.fine('previous');
    animationSense = AnimationSense.previous;
    finalPosition = setPreviousPosition(7);
    days.insertAll(0, context.appState.days);

    animationController
      ..reset()
      ..forward();
  }

  List<double> setPreviousPosition(int length) {
    log.fine('setPreviousPosition');
    List<double> tempPosition = [];
    for (int i = 0; i < (7 + length); i++) {
      tempPosition.add(
        height * i -
            (length * height) +
            (length * height) * positionAnimation.value,
      );
    }
    return tempPosition;
  }

  forward() {
    log.fine('forward');
    animationSense = AnimationSense.forward;
    finalPosition = setForwardPosition(7);
    days.insertAll(7, context.appState.days);

    animationController
      ..reset()
      ..forward();
  }

  List<double> setForwardPosition(int length) {
    log.fine('setForwardPosition');
    List<double> tempPosition = [];
    for (int i = 0; i < (7 + length); i++) {
      tempPosition
          .add(height * i - (length * height) * positionAnimation.value);
    }
    return tempPosition;
  }

  @override
  void dispose() {
    log.fine('dispose');
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log.fine('build');
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height * 7,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  for (int i = 0; i < days.length; i++)
                    Positioned(
                      top: finalPosition[i],
                      left: 0,
                      right: 0,
                      child: ItemWidget(
                        key: Key(days[i].day.toString()),
                        day: days[i],
                        isDoublePadding: widget.isDoublePadding,
                        secondaryColor: widget.secondaryColor,
                        onSecondaryColor: widget.onSecondaryColor,
                        primaryColor: widget.primaryColor,
                        disableColor: widget.disableColor,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
