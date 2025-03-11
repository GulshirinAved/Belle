// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/utils/utils.dart';

import '../../../../features/client/client.dart';
import '../../../../theme/theme.dart';

class AvailableDatesCalendarWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<DateTime> onPageChanged;
  final List<DateModel>? dates;
  final bool isLoading;
  final DateTime? focusedDay;
  final CalendarButtonStyle buttonStyle;

  const AvailableDatesCalendarWidget({
    super.key,
    required this.onDateChanged,
    required this.onPageChanged,
    required this.dates,
    required this.isLoading,
    this.focusedDay,
    this.buttonStyle = CalendarButtonStyle.saveButton,
  });

  @override
  State<AvailableDatesCalendarWidget> createState() =>
      _AvailableDatesCalendarWidgetState();
}

class _AvailableDatesCalendarWidgetState
    extends State<AvailableDatesCalendarWidget> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    _focusedDay = widget.focusedDay ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SalonCalendar(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                availability: widget.dates,
                onDateChanged: widget.onDateChanged,
                onPageChanged: (value) {
                  widget.onPageChanged(value);
                  _focusedDay = value;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  widget.onDateChanged(selectedDay);
                },
              ),
              // const Spacer(),
              if (widget.buttonStyle == CalendarButtonStyle.saveButton) ...{
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                    // vertical: AppDimensions.paddingLarge,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(context.loc.save),
                  ),
                ),
              }
            ],
          ),
          if (widget.isLoading) ...[
            Positioned.fill(
              child: ColoredBox(
                color:
                    Theme.of(context).colorScheme.surface.resolveOpacity(0.5),
                child: Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppDimensions.radiusMedium),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(AppDimensions.paddingMedium),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum CalendarButtonStyle { saveButton, noButton }

class _SalonCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final List<DateModel>? availability;
  final Function(DateTime, DateTime) onDaySelected;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<DateTime> onPageChanged;

  const _SalonCalendar({
    required this.focusedDay,
    required this.selectedDay,
    required this.availability,
    required this.onDaySelected,
    required this.onDateChanged,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      enabledDayPredicate: (day) {
        final isAfterToday =
            !day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
        final isAvailable = availability?.any(
                (el) => isSameDay(el.date, day) && el.isAvailable == true) ??
            false;
        return isAfterToday && isAvailable;
      },
      onDaySelected: (selectedDay, focusedDay) {
        final isAfterToday = !selectedDay
            .isBefore(DateTime.now().subtract(const Duration(days: 1)));
        final isAvailable = availability?.any((el) =>
                isSameDay(el.date, selectedDay) && el.isAvailable == true) ??
            false;
        if (isAfterToday && isAvailable) {
          onDaySelected(selectedDay, focusedDay);
        }
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        selectedTextStyle: Theme.of(context).textTheme.bodyMedium!,
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: context.loc.localeName,
      onPageChanged: onPageChanged,
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, day, focusedDay) {
          final isAvailable = availability
                  ?.firstWhere((el) => isSameDay(el.date, day), orElse: () {
                return const DateModel(isAvailable: false);
              }).isAvailable ??
              false;

          if (!isAvailable) {
            return _UnavailableDayWidget(day: day);
          }
          return _TodayDayWidget(day: day);
        },
        disabledBuilder: (context, day, focusedDay) {
          if (day.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
            return null;
          } else {
            return _UnavailableDayWidget(day: day);
          }
        },
        selectedBuilder: (context, day, focusedDay) {
          return _SelectedDayWidget(day: day);
        },
        defaultBuilder: (context, day, focusedDay) {
          final isAvailable = availability
                  ?.firstWhere((el) => isSameDay(el.date, day), orElse: () {
                return const DateModel(isAvailable: false);
              }).isAvailable ??
              false;

          if (!isAvailable) {
            if (day.isBefore(DateTime.now())) {
              return null;
            }
            return _UnavailableDayWidget(day: day);
          }
          return _AvailableDayWidget(day: day);
        },
      ),
    );
  }
}

class _SelectedDayWidget extends StatelessWidget {
  final DateTime day;

  const _SelectedDayWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${day.day}',
        ),
      ),
    );
  }
}

class _UnavailableDayWidget extends StatelessWidget {
  final DateTime day;

  const _UnavailableDayWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingExtraSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
        ),
      ),
    );
  }
}

class _AvailableDayWidget extends StatelessWidget {
  final DateTime day;

  const _AvailableDayWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingExtraSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class _TodayDayWidget extends StatelessWidget {
  final DateTime day;

  const _TodayDayWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingExtraSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
