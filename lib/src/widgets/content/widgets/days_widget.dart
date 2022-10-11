import 'package:flutter/material.dart';
// import 'package:logging/logging.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/helpers/widget_helper.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/widgets/content/widgets/item_widget.dart';

enum AnimationSense { none, previous, forward }

class DaysWidget extends StatefulWidget {
  final List<DayModel> days;
  final double height;
  final bool isDoublePadding;

  const DaysWidget({
    super.key,
    required this.days,
    required this.height,
    required this.isDoublePadding,
  });

  @override
  State<DaysWidget> createState() => _DaysWidgetState();
}

class _DaysWidgetState extends State<DaysWidget>
    with SingleTickerProviderStateMixin {
  // final log = Logger('DayWidget');
  late List<DayModel> days;
  late AnimationController animationController;
  late Animation positionAnimation;
  AnimationSense animationSense = AnimationSense.none;
  double firstPosition = 0.0;
  AnimationSense dragCallBack = AnimationSense.none;
  @override
  void initState() {
    super.initState();
    days = widget.days;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
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
            firstPosition = (widget.height * 7) * (positionAnimation.value - 1);
          } else {
            firstPosition = -(widget.height * 7) * positionAnimation.value;
          }

          if (positionAnimation.isCompleted) {
            if (animationSense == AnimationSense.previous) {
              days.removeRange(7, 14);
            } else if (animationSense == AnimationSense.forward) {
              days.removeRange(0, 7);
            }
            firstPosition = 0.0;
            animationSense = AnimationSense.none;
            dragCallBack = AnimationSense.none;
          }
        },
      );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DaysWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!listEquality(days, widget.days)) {
      if (animationSense != AnimationSense.none) {
        if (animationSense == AnimationSense.previous) {
          days.removeRange(7, 14);
        } else {
          days.removeRange(0, 7);
        }
      }
      firstPosition = 0.0;
      animationSense = AnimationSense.none;
      if (days[0].day.isAfter(widget.days[0].day)) {
        previous();
      } else {
        next();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: ((context, child) {
        return GestureDetector(
          onVerticalDragUpdate: (details) {
            if (dragCallBack == AnimationSense.none) {
              if (details.delta.dy > 7 && (!context.appState.isFirst.value)) {
                dragCallBack = AnimationSense.previous;
                context.appState.previousWeek();
                // log.info('previousWeek');
              } else if (details.delta.dy < -7 &&
                  (!context.appState.isLast.value)) {
                dragCallBack = AnimationSense.forward;
                context.appState.nextWeek();
                // log.info('next');
              }
            }
          },
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              for (int i = 0; i < days.length; i++)
                Positioned(
                  top: firstPosition + widget.height * i,
                  left: 0,
                  right: 0,
                  child: ItemWidget(
                    key: Key(days[i].day.toString()),
                    day: days[i],
                    isDoublePadding: widget.isDoublePadding,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  next() {
    animationSense = AnimationSense.forward;
    days.addAll(widget.days);
    animationController
      ..reset()
      ..forward();
  }

  previous() {
    animationSense = AnimationSense.previous;
    days.insertAll(0, widget.days);
    firstPosition = -(widget.height * 7);
    animationController
      ..reset()
      ..forward();
  }
}
