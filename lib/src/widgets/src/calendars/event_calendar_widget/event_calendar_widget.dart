import 'package:belle/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../features/master/master.dart';
import '../../../../features/shared/shared.dart';

class EventCalendarWidget extends StatefulWidget {
  final List<MasterCalendarBookingDto> events;
  final ValueChanged<MasterCalendarBookingDto> onEventTap;
  final DateTime initialDate;
  final ValueChanged<DateTime> onViewChanged;

  const EventCalendarWidget({
    super.key,
    required this.events,
    required this.onEventTap,
    required this.initialDate,
    required this.onViewChanged,
  });

  @override
  State<EventCalendarWidget> createState() => _EventCalendarWidgetState();
}

class _EventCalendarWidgetState extends State<EventCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      allowDragAndDrop: false,
      dataSource: SalonEventDataSource(widget.events),
      firstDayOfWeek: 1,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeIntervalHeight: 100,
        timeFormat: 'HH:mm',
      ),
      showCurrentTimeIndicator: true,
      headerStyle: const CalendarHeaderStyle(
        textAlign: TextAlign.center,
      ),
      view: CalendarView.day,
      cellBorderColor: Colors.transparent,
      initialDisplayDate: widget.initialDate,
      onViewChanged: (value) {
        widget.onViewChanged(value.visibleDates.first);
      },
      appointmentBuilder: (context, details) {
        final MasterCalendarBookingDto event = details.appointments.first;
        return EventTile(
          event: event,
          onTap: () {
            widget.onEventTap(event);
          },
        );
      },
    );
  }
}

class SalonEventDataSource
    extends CalendarDataSource<MasterCalendarBookingDto> {
  SalonEventDataSource(List<MasterCalendarBookingDto> events) {
    final newEvents = [];
    for (final event in events) {
      if (event.status == BookingStatus.cancelled) {
        continue;
      }
      newEvents.add(event);
    }
    appointments = newEvents;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;

  @override
  String getSubject(int index) => appointments![index].title;

  @override
  Color getColor(int index) => appointments![index].color;
}

class EventTile extends StatelessWidget {
  final MasterCalendarBookingDto event;
  final VoidCallback onTap;

  const EventTile({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.black,
        );
    final titleTextStyle =
        context.textTheme.containerTitle.copyWith(color: AppColors.black);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
          vertical: AppDimensions.paddingExtraSmall,
        ),
        decoration: BoxDecoration(
          color: event.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // required 1
              Row(
                children: [
                  Expanded(
                    child: Text(
                      event.client?.fullName ?? '',
                      style: titleTextStyle,
                    ),
                  ),
                  Text(
                    '${event.from.hour}:${event.from.minute.toString().padLeft(2, '0')} - ${event.to.hour}:${event.to.minute.toString().padLeft(2, '0')}',
                    style: titleTextStyle,
                  ),
                ],
              ),
              // optional 3
              if (event.services != null && event.services!.isNotEmpty)
                ...event.services?.map(
                      (e) => Text(
                        e.name ?? '',
                        style: defaultTextStyle,
                      ),
                    ) ??
                    [],
              // optional 4
              Text(
                event.totalPrice.toString(),
                style: defaultTextStyle,
              ),
              // required 2
              Text(
                '+993 ${event.client?.phone ?? '???'}',
                style: defaultTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
