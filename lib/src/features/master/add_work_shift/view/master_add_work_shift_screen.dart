import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../master.dart';

class MasterAddWorkShiftScreen extends StatefulWidget {
  const MasterAddWorkShiftScreen({super.key});

  @override
  State<MasterAddWorkShiftScreen> createState() =>
      _MasterAddWorkShiftScreenState();
}

class _MasterAddWorkShiftScreenState extends State<MasterAddWorkShiftScreen> {
  final stateController = GetIt.instance<MasterAddWorkShiftStateController>();
  final controller = GetIt.instance<MasterAddWorkShiftController>();

  @override
  void initState() {
    stateController.setContext(context);
    controller.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.schedule,
        isSliver: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Observer(builder: (context) {
          return StyledBackgroundContainer(
            child: ElevatedButtonWithState(
              isLoading: controller.stateManager.isLoading,
              onPressed: stateController.isValidated
                  ? () async {
                      final data = stateController.generateData();
                      await controller.sendData(data);
                      if (!controller.stateManager.isSuccess) {
                        return;
                      }
                      if (!context.mounted) {
                        return;
                      }
                      context.pop(true);
                    }
                  : null,
              child: Text(context.loc.save),
            ),
          );
        }),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            StyledBackgroundContainer(
              child: StyledContainerWithColumn(
                items: [
                  Observer(builder: (context) {
                    return StyledRowWithIcon(
                      title: context.loc.frequency,
                      content: stateController.selectedLifetime?.name,
                      onTap: () {
                        stateController.showFrequencyPicker();
                      },
                    );
                  }),
                  const Divider(height: 0.0),
                  Observer(
                    builder: (context) {
                      return StyledRowWithIcon(
                        title: context.loc.schedule,
                        content: stateController.scheduleContent,
                        onTap: () {
                          stateController.showSchedulePicker();
                        },
                      );
                    },
                  ),
                  const Divider(height: 0.0),
                  Observer(
                    builder: (context) {
                      return StyledRowWithIcon(
                        title: context.loc.break_time,
                        content: stateController.breakTimeContent,
                        onTap: () {
                          stateController.showBreakTimePicker();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const VSpacer(AppDimensions.paddingLarge),
            StyledBackgroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.loc.choose_days,
                    style: context.textTheme.appTitle,
                  ),
                  const Divider(),
                  buildWeekDaysSelector(context),
                ],
              ),
            ),
            const VSpacer(AppDimensions.paddingLarge),
            Observer(builder: (context) {
              final isNotSelected = stateController.selectedLifetime == null;
              if (isNotSelected) {
                return const SizedBox();
              }
              return StyledBackgroundContainer(
                child: Observer(builder: (context) {
                  if (stateController.selectedLifetime!.id == 4) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.choose_schedule_range,
                          style: context.textTheme.appTitle,
                        ),
                        const Divider(),
                        ScheduleDateRangeCalendar(
                          focusedDay: DateTime.now(),
                          rangeStartDay: stateController.rangeStartDate,
                          rangeEndDay: stateController.rangeEndDate,
                          onRangeSelected: (start, end) {
                            stateController.changeRangeDates(start, end);
                          },
                        ),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.choose_schedule_start_date,
                        style: context.textTheme.appTitle,
                      ),
                      const Divider(),
                      ScheduleDateStartCalendar(
                        focusedDay: DateTime.now(),
                        selectedDay: stateController.selectedDate,
                        onDaySelected: (selectedDay, focusedDay) {
                          stateController.changeSelectedDate(selectedDay);
                        },
                      )
                    ],
                  );
                }),
              );
            }),
            const VSpacer(AppDimensions.paddingMedium),
          ],
        ),
      ),
    );
  }

  Widget buildWeekDaysSelector(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    const minItemWidth = 80.0;
    final maxItemsInRow = (screenWidth / minItemWidth).floor();
    final itemWidth = screenWidth / maxItemsInRow;

    final weekDaysWidgets = weekDays.map(
      (day) {
        return SizedBox(
          width: itemWidth,
          child: Observer(
            builder: (context) {
              return WeekDaySelectorButton(
                isSelected: stateController.selectedDays.contains(day),
                onTap: () {
                  stateController.toggleDay(day);
                },
                day: day,
              );
            },
          ),
        );
      },
    ).toList();
    weekDaysWidgets.add(
      SizedBox(width: itemWidth),
    );

    return Wrap(
      runSpacing: AppDimensions.paddingExtraSmall,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: weekDaysWidgets,
    );
  }
}

class WeekDaySelectorButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final int day;

  const WeekDaySelectorButton({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
        ),
        child: Text(
          DateTimeParser.getWeekdayName(
            context,
            day,
            isFullSize: false,
          ),
        ),
      );
    }
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColors.white,
        ),
        foregroundColor: AppColors.white,
        visualDensity: VisualDensity.compact,
      ),
      child: Text(
        DateTimeParser.getWeekdayName(
          context,
          day,
          isFullSize: false,
        ),
      ),
    );
  }
}

class StyledRowWithIcon extends StatelessWidget {
  final String title;
  final String? content;
  final VoidCallback onTap;

  const StyledRowWithIcon({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingMedium,
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Row(
            spacing: AppDimensions.paddingMedium,
            children: [
              Text(title),
              const Spacer(),
              if (content != null) ...[
                Text(content ?? ''),
              ],
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FrequencyPicker extends StatelessWidget {
  final ValueChanged<LifetimeDto?> onChanged;
  final List<LifetimeDto>? items;
  final LifetimeDto? selectedItem;

  const FrequencyPicker({
    super.key,
    required this.onChanged,
    required this.items,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingLarge,
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimensions.radiusLarge,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: items?.map((item) {
                      return Column(
                        children: [
                          RadioListTile(
                            value: item,
                            groupValue: selectedItem,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(item.name ?? ''),
                            onChanged: onChanged,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: item == items?.first
                                    ? const Radius.circular(
                                        AppDimensions.radiusLarge)
                                    : Radius.zero,
                                bottom: item == items?.last
                                    ? const Radius.circular(
                                        AppDimensions.radiusLarge)
                                    : Radius.zero,
                              ),
                            ),
                          ),
                          if (item != items?.last) const Divider(height: 0.0),
                        ],
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
            ),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppColors.white,
                ),
                foregroundColor: AppColors.white,
              ),
              child: Text(context.loc.cancel),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTimePickerWithTitle extends StatefulWidget {
  final DateTime? initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String title;

  const CustomTimePickerWithTitle({
    super.key,
    this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    required this.onDateSelected,
    required this.title,
  });

  @override
  State<CustomTimePickerWithTitle> createState() =>
      _CustomTimePickerWithTitleState();
}

class _CustomTimePickerWithTitleState extends State<CustomTimePickerWithTitle> {
  DateTime? chosenDate;
  DateTime initialDateTime = DateTime.now();

  @override
  void initState() {
    final currentDate = DateTime.now();
    final currentTimeWithInterval = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      currentDate.hour,
      currentDate.minute < 30 ? 0 : 30,
    );
    initialDateTime = widget.initialDateTime ?? currentTimeWithInterval;
    chosenDate = widget.initialDateTime ?? currentTimeWithInterval;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const VSpacer(AppDimensions.paddingLarge),
          Text(widget.title, style: context.textTheme.appTitle),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: initialDateTime,
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              minuteInterval: 30,
              use24hFormat: true,
              onDateTimeChanged: (value) {
                HapticFeedback.selectionClick();
                SystemSound.play(SystemSoundType.click);
                chosenDate = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge),
            child: Row(
              spacing: AppDimensions.paddingMedium,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.white,
                      ),
                      foregroundColor: AppColors.white,
                    ),
                    child: Text(context.loc.cancel),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, chosenDate);
                      widget.onDateSelected(chosenDate);
                    },
                    child: Text(context.loc.continue_title),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleDateStartCalendar extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;

  const ScheduleDateStartCalendar({
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    super.key,
  });

  @override
  State<ScheduleDateStartCalendar> createState() =>
      _ScheduleDateStartCalendarState();
}

class _ScheduleDateStartCalendarState extends State<ScheduleDateStartCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: widget.focusedDay,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      enabledDayPredicate: (day) =>
          !day.isBefore(DateTime.now().subtract(const Duration(days: 1))),
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(selectedDay, focusedDay);
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        todayDecoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          shape: BoxShape.circle,
        ),
        todayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        selectedTextStyle: Theme.of(context).textTheme.bodyMedium!,
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: context.loc.localeName,
    );
  }
}

class ScheduleDateRangeCalendar extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime? rangeStartDay;
  final DateTime? rangeEndDay;
  final Function(DateTime, DateTime) onRangeSelected;

  const ScheduleDateRangeCalendar({
    required this.focusedDay,
    this.rangeStartDay,
    this.rangeEndDay,
    required this.onRangeSelected,
    super.key,
  });

  @override
  State<ScheduleDateRangeCalendar> createState() =>
      _ScheduleDateRangeCalendarState();
}

class _ScheduleDateRangeCalendarState extends State<ScheduleDateRangeCalendar> {
  DateTime? rangeStartDay;
  DateTime? rangeEndDay;

  @override
  void initState() {
    super.initState();
    rangeStartDay = widget.rangeStartDay ?? DateTime.now();
    rangeEndDay =
        widget.rangeEndDay ?? DateTime.now().add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: widget.focusedDay,
      rangeStartDay: rangeStartDay,
      rangeEndDay: rangeEndDay,
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      enabledDayPredicate: (day) =>
          !day.isBefore(DateTime.now().subtract(const Duration(days: 1))),
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          rangeStartDay = start;
          rangeEndDay = end;
        });
        if (start != null && end != null) {
          widget.onRangeSelected(start, end);
        }
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        todayDecoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          shape: BoxShape.circle,
        ),
        todayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        selectedTextStyle: Theme.of(context).textTheme.bodyMedium!,
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        rangeHighlightColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
        rangeStartDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        rangeStartTextStyle: Theme.of(context).textTheme.bodyMedium!,
        rangeEndTextStyle: Theme.of(context).textTheme.bodyMedium!,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: context.loc.localeName,
    );
  }
}
