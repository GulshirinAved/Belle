import 'package:flutter/material.dart';

const int timeIntervalMinutes = 30;

class CalculateSelectedTimeService {
  static bool canSelectTime(
    TimeOfDay startTime,
    int durationMinutes,
    List<TimeOfDay> availableDates,
    List<TimeOfDay> disabledDates,
  ) {
    final requiredSlots = (durationMinutes / timeIntervalMinutes).ceil();
    final slots = getAvailableSlots(
        startTime, requiredSlots, availableDates, disabledDates);
    return slots.length == requiredSlots;
  }

  static List<TimeOfDay> getAvailableSlots(
    TimeOfDay startTime,
    int requiredSlots,
    List<TimeOfDay> availableDates,
    List<TimeOfDay> disabledDates,
  ) {
    final List<TimeOfDay> result = [];
    TimeOfDay currentTime = startTime;

    for (int i = 0; i < requiredSlots; i++) {
      if (availableDates.contains(currentTime) &&
          !disabledDates.contains(currentTime)) {
        result.add(currentTime);
        currentTime = _incrementTime(currentTime, timeIntervalMinutes);
      } else {
        break;
      }
    }

    return result;
  }

  static TimeOfDay _incrementTime(TimeOfDay time, int minutes) {
    final totalMinutes = time.hour * 60 + time.minute + minutes;
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }
}

class DateGroupingService {
  static List<List<TimeOfDay?>> groupDates(List<TimeOfDay> times,
      {int groupSize = 2}) {
    final List<List<TimeOfDay?>> result = [];
    for (int i = 0; i < times.length; i += groupSize) {
      final group = <TimeOfDay?>[];
      for (int j = 0; j < groupSize; j++) {
        if (i + j < times.length) {
          group.add(times[i + j]);
        } else {
          group.add(null);
        }
      }
      result.add(group);
    }
    return result;
  }
}
