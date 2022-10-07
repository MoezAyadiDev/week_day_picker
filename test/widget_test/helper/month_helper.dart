import '../../unit_test/helper/service_helper.dart';
import 'widget_helper.dart';

class MonthHelper {
  final InitialValue current;
  const MonthHelper(this.current);

  String initialValue() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Basic':
        initialMonthNumber = 10;
        break;
      case 'Basic With initial Value':
        initialMonthNumber = 9;
        break;
      case 'Previous and Next week Check':
        initialMonthNumber = 6;
        break;
      case 'Diffirent year':
        initialMonthNumber = 12;
        break;
      default:
        initialMonthNumber = 1;
    }
    return TestHelper.expectedMonthModel[initialMonthNumber - 1].month;
  }

  String nextWeek() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Basic':
        initialMonthNumber = 10;
        break;
      case 'Basic With initial Value':
        initialMonthNumber = 10;
        break;
      case 'Previous and Next week Check':
        initialMonthNumber = 6;
        break;
      case 'Diffirent year':
        initialMonthNumber = 1;
        break;
      default:
        initialMonthNumber = 1;
    }
    return TestHelper.expectedMonthModel[initialMonthNumber - 1].month;
  }

  String previousWeek() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Basic':
        initialMonthNumber = 9;
        break;
      case 'Basic With initial Value':
        initialMonthNumber = 9;
        break;
      case 'Previous and Next week Check':
        initialMonthNumber = 6;
        break;
      case 'Diffirent year':
        initialMonthNumber = 12;
        break;
      default:
        initialMonthNumber = 1;
    }
    return TestHelper.expectedMonthModel[initialMonthNumber - 1].month;
  }

  String yearChanged() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Basic':
        initialMonthNumber = 9;
        break;
      case 'Basic With initial Value':
        initialMonthNumber = 8;
        break;
      case 'Previous and Next week Check':
        initialMonthNumber = 6;
        break;
      case 'Diffirent year':
        initialMonthNumber = 4;
        break;
      default:
        initialMonthNumber = 1;
    }
    return TestHelper.expectedMonthModel[initialMonthNumber - 1].month;
  }

  String changeMonth() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Basic':
        initialMonthNumber = 11;
        break;
      case 'Basic With initial Value':
        initialMonthNumber = 6;
        break;
      case 'Previous and Next week Check':
        initialMonthNumber = 6;
        break;
      case 'Diffirent year':
        initialMonthNumber = 11;
        break;
      default:
        initialMonthNumber = 1;
    }
    return TestHelper.expectedMonthModel[initialMonthNumber - 1].month;
  }

  String monthChanged() {
    int initialMonthNumber;
    switch (current.type) {
      case 'Basic':
        initialMonthNumber = 11;
        break;
      case 'Basic With initial Value':
        initialMonthNumber = 6;
        break;
      case 'Previous and Next week Check':
        initialMonthNumber = 6;
        break;
      case 'Diffirent year':
        initialMonthNumber = 11;
        break;
      default:
        initialMonthNumber = 1;
    }
    return TestHelper.expectedMonthModel[initialMonthNumber - 1].month;
  }
}
