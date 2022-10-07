import 'package:week_day_picker/src/helpers/extensions.dart';

DateTime dateOnly(DateTime date) {
  return date.dateOnly;
}

DateTime dateOnlyCompose(int year, int month, int day) {
  return DateTime(year, month, day).dateOnly;
}

String timeOnly(DateTime date) {
  return "${date.hour}:${date.minute}:${date.second}";
}
