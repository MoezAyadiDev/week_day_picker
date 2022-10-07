import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_day_picker/src/helpers/extensions.dart';
import 'package:week_day_picker/src/models/day_model.dart';

class ItemWidget extends StatelessWidget {
  final DayModel day;
  final bool isDoublePadding;

  const ItemWidget({
    super.key,
    required this.day,
    required this.isDoublePadding,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: context.appState.selectedDate,
      builder: (context, value, child) {
        bool isSelected = value == day.day;
        bool isCurrentDate = context.appState.currentdate == day.day;

        return Container(
          key: Key(DateFormat('yyyyMMdd').format(day.day)),
          height: isDoublePadding ? 40.0 : 30,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(
            vertical: isSelected ? 2.0 : 3.0,
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
                    context.appState.selectedDateChanged(day.day);
                  }
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical:
                    isDoublePadding ? 7.0 : 0, //isDoublePadding ? 7.0 : 2.0,
              ),
              decoration: BoxDecoration(
                color: isSelected ? context.color.selectedColor : null,
                borderRadius: BorderRadius.circular(20.0),
                border: isSelected
                    ? Border.all(
                        color: context.color.headerColor.withOpacity(0.5),
                      )
                    : isCurrentDate
                        ? Border.all(
                            color: context.color.iconColor,
                            width: 0.7,
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
                              color: context.color.onSelectedColor,
                            )
                        : day.isAllowed
                            ? null
                            : Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: context.color.disableColor,
                                ),
                  ),
                  Text(
                    DateFormat('dd MMM').format(day.day),
                    style: isSelected
                        ? Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: context.color.onSelectedColor,
                            )
                        : day.isAllowed
                            ? null
                            : Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: context.color.disableColor,
                                ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
