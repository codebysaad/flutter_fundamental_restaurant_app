import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {

    final now = DateTime.now();
    final date = DateFormat('y/M/d');
    const time = "11:00:00";
    final fixFormat = DateFormat('y/M/d H:m:s');

    final todayDate = date.format(now);
    final todayDateAndTime = "$todayDate $time";
    final resultToday = fixFormat.parseStrict(todayDateAndTime);

    final formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = date.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $time";
    final resultTomorrow = fixFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
