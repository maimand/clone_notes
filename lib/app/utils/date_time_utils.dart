import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatFromBEToFEDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return '';
    }
    return DateTime.parse(dateTime).toFETimeFormat();
  }

  static String formatFromBEToFEDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return '';
    }
    return DateTime.parse(dateTime).toFEFormat();
  }
}

extension DateTimeDDMMYYYY on DateTime {
  String toFEFormat() => DateFormat('dd/MM/yyyy').format(this);

  String toFETimeFormat() => DateFormat('dd/MM/yyyy - HH:mm').format(this);

  String toBEFormat() => DateFormat('yyyy-MM-dd').format(this);
}
