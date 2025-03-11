import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/widgets.dart';
import '../../master.dart';

class MasterEditWorkShiftScreen extends StatefulWidget {
  final MasterWorkShiftDto dto;

  const MasterEditWorkShiftScreen({super.key, required this.dto});

  @override
  State<MasterEditWorkShiftScreen> createState() =>
      _MasterEditWorkShiftScreenState();
}

class _MasterEditWorkShiftScreenState extends State<MasterEditWorkShiftScreen> {
  final stateController = GetIt.instance<MasterEditWorkShiftStateController>();
  final controller = GetIt.instance<MasterEditWorkShiftController>();

  @override
  void initState() {
    stateController.setContext(context);
    stateController.initWorkShift(widget.dto);
    controller.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.edit,
        isSliver: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Observer(builder: (context) {
          return StyledBackgroundContainer(
            child: Row(
              spacing: AppDimensions.paddingMedium,
              children: [
                Expanded(
                  child: ElevatedButtonWithState(
                    isLoading: controller.stateManager.isLoading,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () async {
                      await controller.deleteWorkShift(widget.dto);
                      if (!controller.stateManager.isSuccess) {
                        return;
                      }
                      if (!context.mounted) {
                        return;
                      }
                      context.pop(true);
                    },
                    child: Text(context.loc.delete),
                  ),
                ),
                Expanded(
                  flex: 2,
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
                ),
              ],
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
