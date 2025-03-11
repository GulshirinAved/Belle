import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeParser {
  static String parseDate(DateTime date, String symbol) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return "$day$symbol$month$symbol$year";
  }

  static String parseTime(DateTime date, String symbol) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return "$hour$symbol$minute";
  }

  static String parseDateRange(DateTimeRange dateTimeRange, String locale) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    String parsedDate = '';
    if (start == end) {
      parsedDate = DateFormat.yMMMMd(locale).format(start);
      return parsedDate;
    }
    if (start.month == end.month && start.year == end.year) {
      parsedDate = '${start.day}-${DateFormat('yMMMMd', locale).format(end)}';
      return parsedDate;
    }

    if (start.year == end.year) {
      parsedDate =
          '${start.day} ${DateFormat('MMM', locale).format(start)} - ${end.day} ${DateFormat('MMM', locale).format(end)} ${end.year}';
      return parsedDate;
    }
    parsedDate =
        '${start.day} ${DateFormat('MMM', locale).format(start)} ${start.year} - ${end.day} ${DateFormat('MMM', locale).format(end)} ${end.year}';
    return parsedDate;
  }

  static String getWeekdayName(BuildContext context, int index,
      {bool isFullSize = true}) {
    /// This date was chosen
    /// because it starts with monday
    DateTime targetDate = DateTime(2018, 1, index);
    final DateFormat dateFormat =
        DateFormat(isFullSize ? 'EEEE' : 'EE', context.loc.localeName);
    String weekdayName = dateFormat.format(targetDate);

    return weekdayName;
  }
}
