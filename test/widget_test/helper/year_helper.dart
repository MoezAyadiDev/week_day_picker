import 'widget_helper.dart';

class YearHelper {
  final InitialValue current;
  const YearHelper(this.current);

  String initialValue() {
    int initialMonthNumber;
    switch (current.type) {
      default:
        initialMonthNumber = 2022;
    }
    return initialMonthNumber.toString();
  }

  String nextWeek() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Diffirent year':
        initialMonthNumber = 2023;
        break;
      default:
        initialMonthNumber = 2022;
    }
    return initialMonthNumber.toString();
  }

  String previousWeek() {
    int initialMonthNumber;
    switch (current.type) {
      default:
        initialMonthNumber = 2022;
    }
    return initialMonthNumber.toString();
  }

  String changeYear() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Previous and Next week Check':
        initialMonthNumber = 2022;
        break;
      case 'Basic With initial Value':
        initialMonthNumber = 2023;
        break;
      case 'Diffirent year':
        initialMonthNumber = 2023;
        break;
      default:
        initialMonthNumber = 2021;
    }
    return initialMonthNumber.toString();
  }
}
