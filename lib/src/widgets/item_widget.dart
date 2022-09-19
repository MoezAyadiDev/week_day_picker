import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:week_day_picker/src/models/day_model.dart';

// class ItemWidget extends StatelessWidget {
//   final DayModel day;
//   const ItemWidget({
//     super.key,
//     required this.day,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.blueAccent),
//           borderRadius: BorderRadius.circular(10.0)),
//       child: Row(
//         children: [
//           Text(day.title),
//           Text(day.day.toString()),
//         ],
//       ),
//     );
//   }
// }

Widget buildItem(DayModel day) => Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[50]!)),
        //borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(day.title),
          ),
          Expanded(
            flex: 1,
            child: Text(day.day.toString()),
          ),
        ],
      ),
    );
