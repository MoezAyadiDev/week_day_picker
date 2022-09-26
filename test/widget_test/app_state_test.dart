

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:week_day_picker/src/helpers/date_helper.dart';
// import 'package:week_day_picker/src/helpers/extensions.dart';
// import 'package:week_day_picker/src/state/app_scope.dart';
// import 'package:week_day_picker/src/week_day_picker.dart';
// import 'package:week_day_picker/src/widgets/week_day_widget.dart';

// import 'helper/constant_helper.dart';

// void main() {
//   testWidgets(
//     'Testing Widget Helper',
//     (WidgetTester tester) async {
//       const Key appStateKey = Key('AppStateKey');
//       const Key appScopeKey = Key('AppScopeKey');
//       AppStateScope appScope = AppStateScope(
//         key: appScopeKey,
//         child: appWidget,
//         data: kAppState,
//       );
//       WeekDayWidget appWidget = WeekDayWidget(
//         key: appStateKey,
//         initialDate: null,
//         firstDate: dateOnlyCompose(2021, 01, 13),
//         lastDate: dateOnlyCompose(2023, 10, 19),
//         selectableDay: null,
//         selectableDayInWeek: const [1, 5],
//         selectableBitwiseOperator: BitwiseOperator.and,
//         child: Container(),
//       );

//       await tester.pumpWidget(appWidget);

//       final StatefulElement appWidgetElement =
//           tester.element(find.byKey(appStateKey));

//       expect(appWidgetElement.widget, equals(appWidget));
//       //expect(appWidgetElement.appState, kAppState);
//     },
//   );
// }
