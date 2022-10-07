import 'widget_helper.dart';

class DayHelper {
  final InitialValue current;
  const DayHelper(this.current);

  List<String> initialValue() {
    List<String> initial;
    switch (current.type) {
      case 'Basic':
        initial = ['20221005', '20221011'];
        break;
      case 'Basic With initial Value':
        initial = ['20220928', '20221004'];
        break;
      case 'Previous and Next week Check':
        initial = ['20220608', '20220614'];
        break;
      case 'Diffirent year':
        initial = ['20221228', '20230103'];
        break;
      default:
        initial = ['20220105', '20220105'];
    }
    return initial;
  }

  List<String> nextWeek() {
    List<String> initial;
    switch (current.type) {
      case 'Basic':
        initial = ['20221012', '20221018'];
        break;
      case 'Basic With initial Value':
        initial = ['20221005', '20221011'];
        break;
      case 'Previous and Next week Check':
        initial = ['20220615', '20220621'];
        break;
      case 'Diffirent year':
        initial = ['20230103', '20230109'];
        break;
      default:
        initial = ['20220105', '20220105'];
    }
    return initial;
  }

  List<String> lastWeek() {
    List<String> initial;
    switch (current.type) {
      case 'Basic':
        initial = ['20220928', '20221004'];
        break;
      case 'Basic With initial Value':
        initial = ['20220922', '20220928'];
        break;
      case 'Previous and Next week Check':
        initial = ['20220601', '20220607'];
        break;
      case 'Diffirent year':
        initial = ['20221222', '20221228'];
        break;
      default:
        initial = ['20220105', '20220105'];
    }
    return initial;
  }
}
