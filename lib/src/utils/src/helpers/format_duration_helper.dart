import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';

@immutable
class FormatDurationHelper {
  const FormatDurationHelper._();

  static String getFormattedDurationByIndex(int index) {
    final duration = (index + 1) * 30; // Время в минутах
    final hours = duration ~/ 60; // Количество часов
    final minutes = duration % 60; // Остаток минут

    if (hours > 0 && minutes > 0) {
      return '$hours ч $minutes мин';
    } else if (hours > 0) {
      return '$hours ч';
    } else {
      return '$minutes мин';
    }
  }

  static String getFormattedDuration(
      BuildContext context, int durationInMinutes) {
    final hours = durationInMinutes ~/ 60; // Количество часов
    final minutes = durationInMinutes % 60; // Остаток минут

    final hourTranslation = context.loc.hour_short;
    final minuteTranslation = context.loc.minute_short;

    if (hours > 0 && minutes > 0) {
      return '$hours $hourTranslation $minutes $minuteTranslation';
    } else if (hours > 0) {
      return '$hours $hourTranslation';
    } else {
      return '$minutes $minuteTranslation';
    }
  }
}
