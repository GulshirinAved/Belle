import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../../../utils/src/helpers/date_time_parser.dart';

class MasterWorkShiftScreen extends StatefulWidget {
  const MasterWorkShiftScreen({super.key});

  @override
  State<MasterWorkShiftScreen> createState() => _MasterWorkShiftScreenState();
}

class _MasterWorkShiftScreenState extends State<MasterWorkShiftScreen> {
  final workShiftsController = GetIt.instance<MasterWorkShiftsController>();
  final holidaysController = GetIt.instance<MasterHolidaysController>();

  final pageViewController = PageController();

  @override
  void initState() {
    workShiftsController.setContext(context);
    workShiftsController.fetchWorkShifts();
    holidaysController.setContext(context);
    holidaysController.fetchHolidays();
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.working_hours,
        isSliver: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet<bool?>(
            context: context,
            useRootNavigator: true,
            useSafeArea: true,
            builder: (context) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                    vertical: AppDimensions.paddingMedium,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(AppDimensions.radiusLarge),
                            ),
                          ),
                          height: 5.0,
                          width: 30.0,
                        ),
                      ),
                      const VSpacer(AppDimensions.paddingLarge),
                      Text(
                        context.loc.add_more,
                        style: context.textTheme.containerTitle,
                        textAlign: TextAlign.center,
                      ),
                      const Divider(
                        height: AppDimensions.paddingLarge * 2,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await context.pushNamed(MasterRoutes.addWorkShift);
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.pop(context);
                          // await pageViewController.animateToPage(
                          //   0,
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeInOut,
                          // );
                          workShiftsController.fetchWorkShifts();
                        },
                        child: Text(context.loc.schedule),
                      ),
                      const VSpacer(AppDimensions.paddingLarge),
                      OutlinedButton(
                        onPressed: () async {
                          await context.pushNamed(MasterRoutes.addVacation);
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.pop(context);

                          // await pageViewController.animateToPage(
                          //   1,
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeInOut,
                          // );
                          holidaysController.fetchHolidays();
                        },
                        child: Text(context.loc.vacation),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium,
              ),
              child: AnimatedToggleWidget<WorkingHoursState>(
                initialValue: WorkingHoursState.active,
                onChanged: (value) {
                  pageViewController.animateToPage(
                    value == WorkingHoursState.active ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                items: [
                  AnimatedToggleWidgetItem(
                    value: WorkingHoursState.active,
                    title: context.loc.active,
                  ),
                  AnimatedToggleWidgetItem(
                    value: WorkingHoursState.vacation,
                    title: context.loc.vacation,
                  ),
                ],
                props: const AnimatedToggleWidgetProps<WorkingHoursState>(),
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ActiveScheduleWidget(
                    key: const ValueKey(WorkingHoursState.active),
                    controller: workShiftsController,
                  ),
                  VacationScheduleWidget(
                    key: const ValueKey(WorkingHoursState.vacation),
                    controller: holidaysController,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum WorkingHoursState {
  active,
  vacation,
}

class ActiveScheduleWidget extends StatefulWidget {
  final MasterWorkShiftsController controller;

  const ActiveScheduleWidget({
    super.key,
    required this.controller,
  });

  @override
  State<ActiveScheduleWidget> createState() => _ActiveScheduleWidgetState();
}

class _ActiveScheduleWidgetState extends State<ActiveScheduleWidget> {
  late final MasterWorkShiftsController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (!controller.stateManager.isSuccess || controller.isEmpty) {
        return StateControlWidget(
          props: StateControlWidgetProps(
            isLoading: controller.stateManager.isLoading,
            isError: controller.stateManager.isError,
            onError: () {
              controller.fetchWorkShifts();
            },
            isEmpty: controller.isEmpty,
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          return await controller.fetchWorkShifts();
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return ActiveScheduleWidgetItem(
              item: item,
              index: index,
              onEditTap: () async {
                final needUpdate = await context.pushNamed<bool?>(
                  MasterRoutes.editWorkShift,
                  extra: item,
                );
                if (needUpdate == null || !needUpdate) {
                  return;
                }
                controller.fetchWorkShifts();
              },
            );
          },
          separatorBuilder: (_, __) {
            return const VSpacer(AppDimensions.paddingMedium);
          },
          itemCount: controller.items.length,
        ),
      );
    });
  }
}

class ActiveScheduleWidgetItem extends StatelessWidget {
  final MasterWorkShiftDto item;
  final int index;
  final VoidCallback onEditTap;

  const ActiveScheduleWidgetItem(
      {super.key,
      required this.item,
      required this.index,
      required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
      child: StyledContainer(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
          horizontal: AppDimensions.paddingMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.paddingSmall,
          children: [
            Text(
              '${index + 1}. ${item.name}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimensions.paddingMedium,
                    children: [
                      VerticalTitleWithContentComponent(
                        title: context.loc.working_days,
                        content:
                            getWorkingDays(context, item.days).toUpperCase(),
                      ),
                      VerticalTitleWithContentComponent(
                        title: context.loc.break_time,
                        content: '${item.breakStart}-${item.breakEnd}',
                      ),
                      VerticalTitleWithContentComponent(
                        title: context.loc.expired_date,
                        content: item.expiresDate,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimensions.paddingMedium,
                    children: [
                      VerticalTitleWithContentComponent(
                        title: context.loc.working_hours,
                        content: '${item.dayStart}-${item.dayEnd}',
                      ),
                      VerticalTitleWithContentComponent(
                        title: context.loc.date_start,
                        content: item.startDate,
                      ),
                      VerticalTitleWithContentComponent(
                        title: context.loc.duration,
                        content: '${item.workshiftDuration}',
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: EditButton(
                    onEditTap: onEditTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getWorkingDays(BuildContext context, List<int>? items) {
    String workingDays = '';
    if (items == null || items.isEmpty) {
      return '';
    }
    for (final item in items) {
      final parsedWeekdayName =
          DateTimeParser.getWeekdayName(context, item, isFullSize: false);
      workingDays += parsedWeekdayName;
      if (item != items.last) {
        workingDays += ', ';
      }
    }
    return workingDays;
  }
}

class VacationScheduleWidget extends StatefulWidget {
  final MasterHolidaysController controller;

  const VacationScheduleWidget({super.key, required this.controller});

  @override
  State<VacationScheduleWidget> createState() => _VacationScheduleWidgetState();
}

class _VacationScheduleWidgetState extends State<VacationScheduleWidget> {
  late final MasterHolidaysController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (!controller.stateManager.isSuccess || controller.isEmpty) {
        return StateControlWidget(
          props: StateControlWidgetProps(
            isLoading: controller.stateManager.isLoading,
            isError: controller.stateManager.isError,
            onError: () {
              controller.fetchHolidays();
            },
            isEmpty: controller.isEmpty,
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          return await controller.fetchHolidays();
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return VacationScheduleWidgetItem(
              index: index,
              item: item,
              onEditTap: () async {
                final needUpdate = await context.pushNamed<bool?>(
                  MasterRoutes.editVacation,
                  extra: item,
                );
                if (needUpdate == null || !needUpdate) {
                  return;
                }
                controller.fetchHolidays();
              },
            );
          },
          separatorBuilder: (_, __) {
            return const VSpacer(AppDimensions.paddingMedium);
          },
          itemCount: controller.items.length,
        ),
      );
    });
  }
}

class VacationScheduleWidgetItem extends StatelessWidget {
  final MasterHolidayDto item;
  final int index;
  final VoidCallback onEditTap;

  const VacationScheduleWidgetItem({
    super.key,
    required this.item,
    required this.index,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      child: StyledContainer(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
          horizontal: AppDimensions.paddingMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.paddingSmall,
          children: [
            Text(
              '${index + 1}. ${item.reason}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: VerticalTitleWithContentComponent(
                    title: context.loc.not_working_days,
                    content:
                        '${context.loc.from} ${item.dateStart}\n${context.loc.to} ${item.dateEnd}',
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: VerticalTitleWithContentComponent(
                    title: context.loc.reason,
                    content: '${item.reason}',
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: EditButton(
                    onEditTap: onEditTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalTitleWithContentComponent extends StatelessWidget {
  final String title;
  final String? content;

  const VerticalTitleWithContentComponent({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final contentStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        );
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.secondaryContainer,
          fontWeight: FontWeight.w500,
        );
    return Column(
      spacing: AppDimensions.paddingExtraSmall,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        Text(content ?? '', style: contentStyle),
      ],
    );
  }
}
