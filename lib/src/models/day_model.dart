import 'package:intl/intl.dart';

class DayModel {
  final String title;
  final DateTime day;
  final bool isAllowed;
  const DayModel({
    required this.title,
    required this.day,
    required this.isAllowed,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          day == other.day &&
          isAllowed == other.isAllowed;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        title,
        day,
        isAllowed,
      );

  @override
  String toString() {
    return 'DayModel(day:${DateFormat('dd/MM/yyyy').format(day)}, title:\'$title\', isAllowed :$isAllowed)';
  }

  String toModel() {
    return 'DayModel(day:${DateFormat('yyyy,MM,dd').format(day)}, title:\'$title\', isAllowed :$isAllowed)';
  }
}
