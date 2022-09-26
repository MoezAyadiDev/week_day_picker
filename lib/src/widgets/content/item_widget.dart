import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';
import 'package:week_day_picker/src/widgets/week_day_widget.dart';

class ItemWidget extends StatelessWidget {
  final DayModel day;
  final bool isDoublePadding;
  final Color secondaryColor;
  final Color onSecondaryColor;
  final Color primaryColor;
  final Color disableColor;
  const ItemWidget({
    super.key,
    required this.day,
    required this.isDoublePadding,
    required this.secondaryColor,
    required this.onSecondaryColor,
    required this.primaryColor,
    required this.disableColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.appState.selectedDate == day.day;
    // bool isAllowed = isAllowedDay(
    //   day.day,
    //   context.appState.firstDate,
    //   context.appState.lastDate,
    //   context.appState.selectableDay,
    //   context.appState.selectableDayInWeek,
    //   context.appState.selectableBitwiseOperator,
    // );

    return Container(
      height: isDoublePadding ? 40.0 : 30,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(
        vertical: isSelected ? 2.0 : 3.0,
        //horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: day.isAllowed
            ? () {
                WeekDayWidget.of(context).setSelectedDate(day.day);
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: isDoublePadding ? 7.0 : 0, //isDoublePadding ? 7.0 : 2.0,
          ),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor : null,
            borderRadius: BorderRadius.circular(20.0),
            border: isSelected
                ? Border.all(
                    color: onSecondaryColor.withOpacity(0.3),
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day.title,
                style: isSelected
                    ? Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: onSecondaryColor,
                        )
                    : day.isAllowed
                        ? null
                        : Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: disableColor,
                            ),
              ),
              Text(
                DateFormat('dd MMM').format(day.day),
                style: isSelected
                    ? Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: onSecondaryColor,
                        )
                    : day.isAllowed
                        ? null
                        : Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: disableColor,
                            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
