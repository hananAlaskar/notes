class DateUtility {

  static final weekDay = {
    1: 'Mon',
    2: 'Tu',
    3: 'Wed',
    4: 'Th',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun'
  };

  static final month = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  static final NUMBER_OF_DAYS_IN_ONE_YEAR = 365;
  static final NUMBER_OF_DAYS_IN_TWO_YEARS = NUMBER_OF_DAYS_IN_ONE_YEAR * 2;

  static String getDate(String noteDateStr) {
    var noteDate = DateTime.parse(noteDateStr);

    var currentDate = DateTime.now();

    if ((-1 * noteDate.difference(currentDate).inDays) >
        NUMBER_OF_DAYS_IN_TWO_YEARS)
      return getLongDate(noteDate);
    else if ((-1 * noteDate.difference(currentDate).inDays) >
        NUMBER_OF_DAYS_IN_ONE_YEAR)
      return getLastYear();
    else if ((-1 * noteDate.difference(currentDate).inDays) > 28)
      return getMonthAndDay(noteDate);
    else if ((-1 * noteDate.difference(currentDate).inDays) >= 1 &&
        (-1 * noteDate.difference(currentDate).inDays) <= 5)
      return getWeekDay(noteDate);
    else if (noteDate.difference(currentDate).inDays != 0)
      return getDaysInSameMonth(noteDate, currentDate);
    else {
      if (noteDate.difference(currentDate).inHours != 0)
        return getHoursInSameDay(noteDate, currentDate);
      else if (noteDate.difference(currentDate).inMinutes != 0)
        return getMinutesInSameHour(noteDate, currentDate);
      else
        return getDateInSameMinute();
    }
  }

  static String getLongDate(noteDate) =>
      noteDate.toString().substring(0, noteDate.toString().indexOf(' '));

  static String getLastYear() => "a year age";
  static String getDateInSameMinute() => "a second age";

  static String getMonthAndDay(noteDate) =>
      noteDate.day.toString() + " " + month[noteDate.month];
  static String getWeekDay(noteDate) => weekDay[noteDate.weekday];

  static String getDaysInSameMonth(noteDate, currentDate) =>
      (-1 * noteDate.difference(currentDate).inDays).toString() + " days age";
  static String getHoursInSameDay(noteDate, currentDate) =>
      (-1 * noteDate.difference(currentDate).inHours).toString() + " hours age";
  static String getMinutesInSameHour(noteDate, currentDate) =>
      (-1 * noteDate.difference(currentDate).inMinutes).toString() +
      " manites age";
}
