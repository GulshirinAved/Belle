// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:belle/src/features/shared/shared.dart';
import 'package:belle/src/widgets/src/calendars/available_dates_calendar_widget/available_dates_calendar_widget.dart';
import 'package:belle/src/widgets/src/styled_background_container.dart';
import 'package:belle/src/widgets/src/styled_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/widgets/src/app_bar_with_styled_leading.dart';
import 'package:belle/src/widgets/src/spacers/spacers.dart';

class RescheduleScreen extends StatefulWidget {
  final ClientBookingsDto clientBookingsDto;

  const RescheduleScreen({
    super.key,
    required this.clientBookingsDto,
  });

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  final GlobalKey _dayChooserListKey = GlobalKey();
  final scrollController = ScrollController();
  final controller = GetIt.instance<ClientMyBookingsController>();
  final masterController = GetIt.instance<ClientBookingMasterInfoController>();
  final calendarController = GetIt.instance<ClientBookingCalendarController>();
  final stateController = GetIt.instance<ClientMyBookingsStateController>();
  final accountController = GetIt.instance<AccountController>();

  bool firstOpen = true;
  Widget _buildDivider(BuildContext context, TimeOfDay? time) {
    if (time == null) return const SizedBox.shrink();

    final disabledSlots = stateController.disabledSlots.toSet();
    final isDisabled = disabledSlots.contains(time);

    Color color = Theme.of(context).colorScheme.secondaryContainer;
    if (isDisabled) {
      color = Theme.of(context).colorScheme.surface;
    }

    return SizedBox(
      width: 55.0,
      child: Divider(
        height: 0.0,
        color: color,
      ),
    );
  }

  void _scrollToDayChooserList(Duration timeStamp) {
    if (!firstOpen) {
      return;
    }
    final RenderObject? renderObject =
        _dayChooserListKey.currentContext?.findRenderObject();
    if (renderObject != null && renderObject is RenderSliver) {
      final RenderSliver renderSliver = renderObject;
      final double targetOffset =
          renderSliver.constraints.precedingScrollExtent - 250.0;
      scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
    firstOpen = false;
  }

  Widget _buildButton(BuildContext context, TimeOfDay? time) {
    if (time == null) return const SizedBox.shrink();

    return Observer(
      builder: (context) {
        final disabledSlots = stateController.disabledSlots.toSet();
        final selectedSlots = stateController.selectedSlots.toSet();

        final isDisabled = disabledSlots.contains(time);
        final isSelected = selectedSlots.contains(time);

        final title = MaterialLocalizations.of(context).formatTimeOfDay(
          time,
          alwaysUse24HourFormat: true,
        );
        log("Slot: $time, Disabled: $isDisabled, Selected: $isSelected");

        if (isDisabled) {
          return SizedBox(
            width: 75.0,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
              child: Text(title),
            ),
          );
        }

        return SizedBox(
          width: 75.0,
          child: ElevatedButton(
            onPressed: () {
              stateController.onSelectSlotTap(time, context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
            ),
            child: Text(title),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
    masterController.setContext(context);
    calendarController.setContext(context);
    getDataAndInit();
    if (accountController.accountInfo != null) {
      final accountInfo = accountController.accountInfo;
    }
    super.initState();
  }

  void getDataAndInit() async {
    await masterController.fetchMasterInfo(
      widget.clientBookingsDto.master!.id!,
      () async {
        await calendarController.postChosenServices(
          ChosenServicesToSendDto(
            masterId: widget.clientBookingsDto.master!.id!,
            subServicesIds: masterController.data!.services!
                .expand((service) => service.subservices ?? [])
                .map<int?>((subservice) => subservice.subserviceId)
                .toList(),
            month: stateController.selectedDate.month,
            year: DateTime.parse(widget.clientBookingsDto.date!).year,
          ),
          (value) {
            stateController.init(value);
            calendarController.init(value);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.reschedule,
        isSliver: false,
      ),
      body: SafeArea(child: Observer(
        builder: (context) {
          // if (!controller.stateManager.isSuccess) {
          //   return StateControlWidget(
          //       props: StateControlWidgetProps(
          //     isLoading: calendarController.stateManager.isLoading,
          //     isError: calendarController.stateManager.isError,
          //     isEmpty: calendarController.data == null,
          //     onError: () {
          //       getDataAndInit();
          //     },
          //   ));
          // }

          return RefreshIndicator.adaptive(
            onRefresh: () async {
              return getDataAndInit();
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: MyBookingStatusWidget(
                    clientBookingsDto: widget.clientBookingsDto,
                    bookingType: BookingType.normal,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: VSpacer(AppDimensions.paddingExtraGiant),
                ),
                SliverToBoxAdapter(
                  child: StyledBackgroundContainer(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.choose_schedule_range,
                            style: context.textTheme.appTitle,
                          ),
                          const Divider(),
                          Observer(builder: (_) {
                            return AvailableDatesCalendarWidget(
                              onDateChanged: (value) {
                                stateController.onSelectDateTap(value);
                              },
                              focusedDay: stateController.selectedDate,
                              buttonStyle: CalendarButtonStyle.noButton,
                              onPageChanged: (value) {
                                stateController.onSelectDateTap(value);
                                calendarController.postChosenServices(
                                    stateController.chosenServicesToSendDto
                                        ?.copyWith(
                                      month: value.month,
                                      year: value.year,
                                    ), (value) {
                                  log('''it copywith
$value''');
                                  stateController.init(value);
                                  calendarController.init(value);
                                });
                              },
                              isLoading:
                                  calendarController.stateManager.isLoading,
                              dates: calendarController.data?.calendar?.dates,
                            );
                          }),
                          const VSpacer(AppDimensions.paddingExtraGiant),
                          Text(
                            context.loc.choose_time_for_services,
                            style: context.textTheme.appTitle,
                          ),
                          const VSpacer(AppDimensions.paddingSmall),
                          Observer(builder: (context) {
                            const groupSize = 2;
                            const itemWidth = 75.0;
                            const itemHeight = 49.5;

                            double calculateAspectRatio(
                                double width, double height, int groupSize) {
                              return width / (height * groupSize);
                            }

                            final double childAspectRatio =
                                calculateAspectRatio(
                                    itemWidth, itemHeight, groupSize);

                            final combinedSlots =
                                stateController.availableSlots +
                                    stateController.disabledSlots;

                            combinedSlots.sort((a, b) => a.compareTo(b));

                            final groupedDates = DateGroupingService.groupDates(
                              combinedSlots,
                              groupSize: groupSize,
                            );

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge,
                                vertical: AppDimensions.paddingMedium,
                              ),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: childAspectRatio,
                                  crossAxisSpacing: AppDimensions.paddingMedium,
                                  mainAxisSpacing: AppDimensions.paddingMedium,
                                ),
                                itemCount: groupedDates.length,
                                itemBuilder: (context, index) {
                                  final group = groupedDates[index];
                                  final widgets = <Widget>[];

                                  for (int i = 0; i < group.length; i++) {
                                    widgets
                                        .add(_buildButton(context, group[i]));

                                    if (i < group.length - 1) {
                                      widgets.add(
                                          _buildDivider(context, group[i]));
                                    }
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: widgets,
                                  );
                                },
                              ),
                            );
                          }),
                          Text(
                            context.loc.service_location,
                            style: context.textTheme.appTitle,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: StyledRadioButton<int>(
                                  value: 1,
                                  groupValue:
                                      stateController.currentServiceLocationId,
                                  onTap: (masterController
                                              .data?.workingLocationsIds
                                              .contains(1) ??
                                          false)
                                      ? (value) {
                                          stateController
                                              .changeCurrentServiceLocationId(
                                                  value);
                                        }
                                      : null,
                                  title:
                                      context.loc.service_locations('in_salon'),
                                ),
                              ),
                              const HSpacer(AppDimensions.paddingMedium),
                              Expanded(
                                child: StyledRadioButton<int>(
                                  value: 2,
                                  groupValue:
                                      stateController.currentServiceLocationId,
                                  onTap: (masterController
                                              .data?.workingLocationsIds
                                              .contains(2) ??
                                          false)
                                      ? (value) {
                                          stateController
                                              .changeCurrentServiceLocationId(
                                                  value);
                                        }
                                      : null,
                                  title: context.loc.service_locations('away'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
      bottomNavigationBar: ColoredBox(
        color: Theme.of(context).colorScheme.secondary,
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingMedium,
            horizontal: AppDimensions.paddingLarge,
          ),
          child: ElevatedButton(
              onPressed: () async {
                final bookingDto = stateController.handleOnContinue(
                    context,
                    widget.clientBookingsDto.master?.id!,
                    masterController.data?.services!
                        .expand((service) => service.subservices ?? [])
                        .map<int?>((subservice) => subservice.subserviceId)
                        .toList());

                await controller.makeBooking(bookingDto);
              },
              child: Text(context.loc.confirm)),
        )),
      ),
    );
  }
}
