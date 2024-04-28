abstract class AppUtils {
  static DateTime fromStringDateTime(String dateTime,
      [bool isReversed = false]) {
    if (isReversed) {
      return DateTime.parse(dateTime);
    } else {
      List<String> parts = dateTime.split(' ');
      List<String> dateParts = parts[0].split('-');
      List<String> timeParts = parts[1].split(':');
      final int year = int.parse(dateParts[2]);
      final int month = int.parse(dateParts[0]);
      final int day = int.parse(dateParts[1]);
      final int hour = int.parse(timeParts[0]);
      final int minute = int.parse(timeParts[1]);
      final int second = int.parse(timeParts[2]);
      return DateTime(year, month, day, hour, minute, second);
    }
  }
}
