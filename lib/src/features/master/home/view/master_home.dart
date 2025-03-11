import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../../client/client.dart';
import '../../../language/language.dart';
import '../../../shared/shared.dart';
import '../../master.dart';

class MasterHomeScreen extends StatefulWidget {
  const MasterHomeScreen({super.key});

  @override
  State<MasterHomeScreen> createState() => _MasterHomeScreenState();
}

class _MasterHomeScreenState extends State<MasterHomeScreen> {
  final _homeController = GetIt.instance<MasterHomeController>();
  final _homeStateController = GetIt.instance<MasterHomeStateController>();

  final fireMessage = GetIt.instance<FireMessage>();
  final _bookingController = GetIt.instance<MasterBookingController>();

  void _onMessageReceived(Map<String, dynamic> data) {
    _homeController.loadAllData();
    ShowSnackHelper.showSnack(
      context,
      SnackStatus.success,
      context.loc.new_message,
      () {
        _handleNotification(data);
      },
      AppColors.gray,
      const Duration(seconds: 8),
    );
  }

  void _handleNotification(Map<String, dynamic> data) async {
    if (data.isEmpty) {
      context.pushNamed(ClientRoutes.notifications);
      return;
    }
    try {
      log('Printing data inside _handleNotification method: $data');
      final notificationData = NotificationDto.fromJson(data);
      return await _handleMasterNotification(notificationData);
    } catch (e) {
      log("Can't parse notification data: $e | Navigate to notifications");
      if (!mounted) {
        return;
      }
      context.pushNamed(ClientRoutes.notifications);
      return;
    }
  }

  Future<void> _handleMasterNotification(NotificationDto data) async {
    if (data.type == 'system') {
      context.pushNamed(MasterRoutes.notifications);
      return;
    }
    if (data.type == 'booking') {
      return await showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        useSafeArea: true,
        builder: (context) {
          return NotificationBookingInfoBottomSheet(
            data: data as NotificationBookingInfoDto,
            controller: _bookingController,
          );
        },
      );
    }
  }

  void _onMessageOpenedApp(Map<String, dynamic> data) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _handleNotification(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _homeController.setContext(context);
    _bookingController.setContext(context);
    _homeStateController.setContext(context);
    _homeController.loadAllData();
    fireMessage.init(_onMessageReceived, _onMessageOpenedApp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(MasterRoutes.ownServices);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          return await _homeController.loadAllData();
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: AppBarLogoComponent(),
              actions: [
                MasterNotificationsButton(),
                LanguageChooseButton(),
              ],
            ),
            Observer(
              builder: (context) {
                if (_homeController.isError) {
                  return StateControlWidget(
                    props: StateControlWidgetProps(
                      isLoading: false,
                      isError: _homeController.isError,
                      isSliver: true,
                      onError: () {
                        _homeController.loadAllData();
                      },
                    ),
                  );
                }
                return SliverFillRemaining(
                  hasScrollBody: true,
                  child: Column(
                    spacing: AppDimensions.paddingMedium,
                    children: [
                      Stack(
                        children: [
                          Opacity(
                            opacity: _homeController
                                    .freeSlotsController.stateManager.isLoading
                                ? 0.5
                                : 1.0,
                            child: FreeSlotsWidget(
                              availableSlots: _homeController
                                  .freeSlotsController.data?.availableSlots,
                            ),
                          ),
                          if (_homeController
                              .freeSlotsController.stateManager.isLoading)
                            const Positioned.fill(child: StackLoadingWidget())
                        ],
                      ),
                      Expanded(
                        child: Observer(builder: (context) {
                          return Stack(
                            children: [
                              Opacity(
                                opacity: _homeController.bookingsController
                                        .stateManager.isLoading
                                    ? 0.5
                                    : 1.0,
                                child: EventCalendarWidget(
                                  events:
                                      _homeController.bookingsController.items,
                                  initialDate:
                                      _homeStateController.selectedDate,
                                  onViewChanged: (date) {
                                    if (_homeController.bookingsController
                                        .stateManager.isLoading) {
                                      return;
                                    }
                                    _homeStateController
                                        .changeSelectedDate(date);
                                    _homeController.bookingsController
                                        .changeDate(date);
                                  },
                                  onEventTap: (info) async {
                                    final needUpdate =
                                        await showModalBottomSheet<bool?>(
                                      context: context,
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      builder: (context) {
                                        return BookingInfoBottomSheet(
                                          data: info,
                                          controller: _bookingController,
                                        );
                                      },
                                    );
                                    if (needUpdate == null) {
                                      return;
                                    }

                                    if (!needUpdate) {
                                      return;
                                    }
                                    _homeController.loadAllData();
                                  },
                                ),
                              ),
                              if (_homeController
                                  .bookingsController.stateManager.isLoading)
                                const Positioned.fill(
                                    child: StackLoadingWidget())
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FreeSlotsWidget extends StatelessWidget {
  final List<String>? availableSlots;

  const FreeSlotsWidget({super.key, this.availableSlots});

  @override
  Widget build(BuildContext context) {
    return StyledBackgroundContainer(
      padding:
          const EdgeInsets.symmetric(vertical: AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
            ),
            child: Text(
              context.loc.free_slots_today,
              style: context.textTheme.appTitle,
            ),
          ),
          const VSpacer(AppDimensions.paddingSmall),
          SizedBox(
            height: 85.0,
            child: GridView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
              ),
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 80.0,
                mainAxisSpacing: AppDimensions.paddingMedium,
                crossAxisSpacing: AppDimensions.paddingMedium,
              ),
              children: availableSlots?.map((e) {
                    return Material(
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppDimensions.radiusSmall),
                          ),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              MasterRoutes.ownServices,
                              extra: MasterBookingInfoRouteModel(time: e),
                            );
                          },
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppDimensions.radiusSmall),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(e),
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 18.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingInfoBottomSheet extends StatefulWidget {
  final MasterCalendarBookingDto data;
  final MasterBookingController controller;

  const BookingInfoBottomSheet({
    super.key,
    required this.data,
    required this.controller,
  });

  @override
  State<BookingInfoBottomSheet> createState() => _BookingInfoBottomSheetState();
}

class _BookingInfoBottomSheetState extends State<BookingInfoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.6,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const VSpacer(AppDimensions.paddingLarge),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppDimensions.radiusLarge),
                    ),
                  ),
                  height: 5.0,
                  width: 30.0,
                ),
              ),
              const VSpacer(AppDimensions.paddingMedium),
              Text(
                context.loc.booking_main_info,
                style: context.textTheme.appTitle,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: AppDimensions.paddingLarge * 2,
              ),
              // TODO: REFACTOR THIS PART
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          ExpansionTile(
                            title: Text(
                              context.loc.personal_info,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            shape: const Border(),
                            visualDensity: VisualDensity.compact,
                            initiallyExpanded: true,
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimensions.paddingLarge,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      spacing: AppDimensions.paddingMedium,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // const Icon(Icons.account_circle_outlined),
                                        Expanded(
                                          // flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            children: [
                                              Text(
                                                context.loc.client,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                widget.data.client?.fullName
                                                        .trim() ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                context.loc.phone_number,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                '+993 ${widget.data.client?.phone ?? ''}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const VSpacer(AppDimensions.paddingMedium),
                                    Row(
                                      children: [
                                        Expanded(
                                          // flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            children: [
                                              Text(
                                                context.loc.date_start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                DateFormat('d MMM yyyy').format(
                                                    DateTime.parse(
                                                        widget.data.date ??
                                                            '')),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                context.loc.time,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                widget.data.time ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          ExpansionTile(
                            title: Text(
                              context.loc.chosen_services(
                                  widget.data.services?.length.toString() ??
                                      ''),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            shape: const Border(),
                            visualDensity: VisualDensity.compact,
                            initiallyExpanded:
                                (widget.data.services?.length ?? 0) < 3,
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge),
                            children: widget.data.services?.map((service) {
                                  return DualToneContainer(
                                    index: widget.data.services
                                            ?.indexOf(service) ??
                                        0,
                                    length: widget.data.services?.length ?? 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppDimensions.paddingMedium,
                                      horizontal: AppDimensions.paddingLarge,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            service.name ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${service.price} TMT | ${FormatDurationHelper.getFormattedDuration(context, service.duration ?? 0)} ',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList() ??
                                [],
                          ),
                          const VSpacer(AppDimensions.paddingLarge),
                        ],
                      ),
                      SizedBox(
                        height: AppDimensions.paddingLarge,
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge,
                          vertical: AppDimensions.paddingMedium,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MasterBookingStatusWidget(
                              bookingId:
                                  widget.data.bookingNumber?.toString() ?? '',
                              currentStatus:
                                  widget.data.status ?? BookingStatus.notFound,
                              onSuccess: _onSuccess,
                            ),
                            const VSpacer(AppDimensions.paddingMedium),
                            Row(
                              spacing: AppDimensions.paddingMedium,
                              children: [
                                Expanded(
                                  child: MasterBookingCancelButton(
                                    bookingId:
                                        widget.data.bookingNumber?.toString() ??
                                            '',
                                    onSuccess: _onSuccess,
                                  ),
                                ),
                                // const HSpacer(AppDimensions.paddingMedium),
                                Expanded(
                                  child: MasterBookingRescheduleButton(
                                    bookingId:
                                        widget.data.bookingNumber?.toString() ??
                                            '',
                                    onSuccess: _onSuccess,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSuccess() async {
    ShowSnackHelper.showSnack(
      context,
      SnackStatus.success,
      context.loc.snack_title('success'),
    );
    if (!mounted) {
      return;
    }
    Navigator.pop(context, true);
  }
}

class NotificationBookingInfoBottomSheet extends StatefulWidget {
  final NotificationBookingInfoDto data;
  final MasterBookingController controller;

  const NotificationBookingInfoBottomSheet({
    super.key,
    required this.data,
    required this.controller,
  });

  @override
  State<NotificationBookingInfoBottomSheet> createState() =>
      _NotificationBookingInfoBottomSheetState();
}

class _NotificationBookingInfoBottomSheetState
    extends State<NotificationBookingInfoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.6,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const VSpacer(AppDimensions.paddingLarge),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppDimensions.radiusLarge),
                    ),
                  ),
                  height: 5.0,
                  width: 30.0,
                ),
              ),
              const VSpacer(AppDimensions.paddingMedium),
              Text(
                context.loc.booking_main_info,
                style: context.textTheme.appTitle,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: AppDimensions.paddingLarge * 2,
              ),
              // TODO: REFACTOR THIS PART
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          ExpansionTile(
                            title: Text(
                              context.loc.personal_info,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            shape: const Border(),
                            visualDensity: VisualDensity.compact,
                            initiallyExpanded: true,
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimensions.paddingLarge,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      spacing: AppDimensions.paddingMedium,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // const Icon(Icons.account_circle_outlined),
                                        Expanded(
                                          // flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            children: [
                                              Text(
                                                context.loc.client,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                widget.data.client?.fullName
                                                        .trim() ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                context.loc.phone_number,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                '+993 ${widget.data.client?.phone ?? ''}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const VSpacer(AppDimensions.paddingMedium),
                                    Row(
                                      children: [
                                        Expanded(
                                          // flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            children: [
                                              Text(
                                                context.loc.date_start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                DateFormat('d MMM yyyy').format(
                                                    DateTime.parse(
                                                        widget.data.date ??
                                                            '')),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing:
                                                AppDimensions.paddingExtraSmall,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                context.loc.time,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                    ),
                                              ),
                                              Text(
                                                widget.data.time ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          ExpansionTile(
                            title: Text(
                              context.loc.chosen_services(
                                  widget.data.services?.length.toString() ??
                                      ''),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            shape: const Border(),
                            visualDensity: VisualDensity.compact,
                            initiallyExpanded:
                                (widget.data.services?.length ?? 0) < 3,
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge),
                            children: widget.data.services?.map((service) {
                                  return DualToneContainer(
                                    index: widget.data.services
                                            ?.indexOf(service) ??
                                        0,
                                    length: widget.data.services?.length ?? 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppDimensions.paddingMedium,
                                      horizontal: AppDimensions.paddingLarge,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            service.name ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${service.price} TMT | ${FormatDurationHelper.getFormattedDuration(context, int.tryParse(service.duration ?? '0') ?? 0)} ',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList() ??
                                [],
                          ),
                          const VSpacer(AppDimensions.paddingLarge),
                        ],
                      ),
                      SizedBox(
                        height: AppDimensions.paddingLarge,
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge,
                          vertical: AppDimensions.paddingMedium,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MasterBookingStatusWidget(
                              bookingId:
                                  widget.data.bookingNumber?.toString() ?? '',
                              currentStatus:
                                  widget.data.status ?? BookingStatus.notFound,
                              onSuccess: _onSuccess,
                            ),
                            const VSpacer(AppDimensions.paddingMedium),
                            Row(
                              spacing: AppDimensions.paddingMedium,
                              children: [
                                Expanded(
                                  child: MasterBookingCancelButton(
                                    bookingId:
                                        widget.data.bookingNumber?.toString() ??
                                            '',
                                    onSuccess: _onSuccess,
                                  ),
                                ),
                                // const HSpacer(AppDimensions.paddingMedium),
                                Expanded(
                                  child: MasterBookingRescheduleButton(
                                    bookingId:
                                        widget.data.bookingNumber?.toString() ??
                                            '',
                                    onSuccess: _onSuccess,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSuccess() async {
    ShowSnackHelper.showSnack(
      context,
      SnackStatus.success,
      context.loc.snack_title('success'),
    );
    if (!mounted) {
      return;
    }
    Navigator.pop(context, true);
  }
}

class MasterNotificationsButton extends StatelessWidget {
  const MasterNotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pushNamed(MasterRoutes.notifications);
      },
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      icon: const Icon(Icons.notifications_none_rounded),
    );
  }
}

class MasterBookingActionButton extends StatefulWidget {
  final String bookingId;
  final BookingStatus status;
  final VoidCallback onSuccess;
  final String label;
  final Color foregroundColor;
  final Color borderColor;
  final IconData? icon;

  const MasterBookingActionButton({
    super.key,
    required this.bookingId,
    required this.status,
    required this.onSuccess,
    required this.label,
    required this.foregroundColor,
    required this.borderColor,
    this.icon,
  });

  @override
  State<MasterBookingActionButton> createState() =>
      _MasterBookingActionButtonState();
}

class _MasterBookingActionButtonState extends State<MasterBookingActionButton> {
  final controller = GetIt.instance<MasterBookingController>();

  Future<void> changeStatus() async {
    await controller.changeStatus(
      widget.bookingId,
      widget.status.id,
      () {
        widget.onSuccess();
      },
    );
  }

  @override
  void initState() {
    controller.setContext(context);
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeContext();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return OutlinedButtonWithState(
        onPressed: changeStatus,
        isLoading: controller.stateManager.isLoading,
        style: OutlinedButton.styleFrom(
          foregroundColor: widget.foregroundColor,
          side: BorderSide(color: widget.borderColor),
        ),
        child: Row(
          spacing: AppDimensions.paddingSmall,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null)
              Icon(
                widget.icon,
                color: widget.foregroundColor,
              ),
            Flexible(child: Text(widget.label))
          ],
        ),
      );
    });
  }
}

class MasterBookingCancelButton extends StatelessWidget {
  final String bookingId;
  final VoidCallback onSuccess;

  const MasterBookingCancelButton({
    super.key,
    required this.bookingId,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return MasterBookingActionButton(
      bookingId: bookingId,
      status: BookingStatus.cancelled,
      onSuccess: onSuccess,
      label: context.loc.cancel,
      foregroundColor: Theme.of(context).colorScheme.error,
      borderColor: Theme.of(context).colorScheme.error,
      icon: Icons.cancel_outlined,
    );
  }
}

class MasterBookingRescheduleButton extends StatelessWidget {
  final String bookingId;
  final VoidCallback onSuccess;

  const MasterBookingRescheduleButton({
    super.key,
    required this.bookingId,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return MasterBookingActionButton(
      bookingId: bookingId,
      status: BookingStatus.reschedule,
      onSuccess: onSuccess,
      label: context.loc.ask_to_reschedule,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      borderColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class StackLoadingWidget extends StatelessWidget {
  const StackLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface.resolveOpacity(0.5),
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
    );
  }
}
