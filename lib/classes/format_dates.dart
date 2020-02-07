import 'package:intl/intl.dart';

class FormatDates {

  String dateFormatShortMDY(String date) {
    if (date != null) {
      return DateFormat.yMMMd().format(DateTime.parse(date));
    }
    return null;
  }

  String dateFormatDayNumber(String date) {
    return DateFormat.d().format(DateTime.parse(date));
  }

  String dateFormatShortDayName(String date) {
    return DateFormat.E().format(DateTime.parse(date));
  }

}