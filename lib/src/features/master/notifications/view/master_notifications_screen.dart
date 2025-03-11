import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/widgets.dart';
import '../../../shared/shared.dart';
import '../../master.dart';

class MasterNotificationsScreen extends StatefulWidget {
  const MasterNotificationsScreen({super.key});

  @override
  State<MasterNotificationsScreen> createState() =>
      _MasterNotificationsScreenState();
}

class _MasterNotificationsScreenState extends State<MasterNotificationsScreen> {
  final controller = GetIt.instance<MasterNotificationsController>();
  final _bookingController = GetIt.instance<MasterBookingController>();

  final _scrollController = ScrollController();

  @override
  void initState() {
    _bookingController.setContext(context);
    controller.setContext(context);
    controller.fetchNotificationsBookings();
    addScrollListener();
    super.initState();
  }

  void addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent *
                  controller.offsetPaginationBoundary &&
          _scrollController.position.maxScrollExtent > 0) {
        controller.fetchMoreNotificationsBookings();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.notifications,
        isSliver: false,
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            return await controller.fetchNotificationsBookings();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              Observer(
                builder: (context) {
                  if (!controller.stateManager.isSuccess ||
                      controller.isEmpty) {
                    return StateControlWidget(
                      props: StateControlWidgetProps(
                        isError: controller.stateManager.isError,
                        isLoading: controller.stateManager.isLoading,
                        isEmpty: controller.isEmpty,
                        onError: controller.fetchNotificationsBookings,
                        isSliver: true,
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLarge),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        final notification = controller.items[index];
                        return Observer(builder: (context) {
                          return MasterNotificationWidget(
                            notification: notification,
                            onTapSuccess: () {
                              controller.fetchNotificationsBookings();
                            },
                            isLoading:
                                _bookingController.stateManager.isLoading,
                          );
                        });
                      },
                      separatorBuilder: (_, __) {
                        return const VSpacer(AppDimensions.paddingMedium);
                      },
                      itemCount: controller.items.length,
                    ),
                  );
                },
              ),
              Observer(builder: (_) {
                if (controller.stateManager.isPaginationLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return const SliverToBoxAdapter();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class MasterNotificationWidget extends StatelessWidget {
  final MasterNotificationBookingDto notification;
  final VoidCallback onTapSuccess;
  final bool isLoading;

  const MasterNotificationWidget({
    super.key,
    required this.notification,
    required this.onTapSuccess,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final headerTextTheme = Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.belleGray,
        );
    final bodyTextTheme = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.black,
        );
    final bodyTextThemeBold = context.textTheme.appTitle.copyWith(
      color: AppColors.black,
      fontSize: 16.0,
    );

    return Container(
      decoration: BoxDecoration(
        color: notification.color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingMedium,
        horizontal: AppDimensions.paddingLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ClientInfoRow(
            notification: notification,
            headerTextTheme: headerTextTheme,
            bodyTextTheme: bodyTextTheme,
            bodyTextThemeBold: bodyTextThemeBold,
          ),
          const Divider(),
          _ServicesColumn(
            notification: notification,
            headerTextTheme: headerTextTheme,
            bodyTextTheme: bodyTextTheme,
            bodyTextThemeBold: bodyTextThemeBold,
          ),
          const Divider(),
          _DateRow(
            notification: notification,
            headerTextTheme: headerTextTheme,
            bodyTextThemeBold: bodyTextThemeBold,
          ),
          const Divider(),
          _StatusRow(
            notification: notification,
            headerTextTheme: headerTextTheme,
            bodyTextThemeBold: bodyTextThemeBold,
          ),
          const Divider(),
          _BookingPaymentRow(
            notification: notification,
            headerTextTheme: headerTextTheme,
            bodyTextThemeBold: bodyTextThemeBold,
          ),
          if (notification.status != BookingStatus.cancelled &&
              notification.status != BookingStatus.reschedule) ...[
            const Divider(),
            _ActionButtonsRow(notification: notification),
            const VSpacer(AppDimensions.paddingLarge),
            MasterBookingStatusWidget(
              // status: notification.status ?? BookingStatus.notFound,
              bookingId: notification.bookingNumber.toString(),
              currentStatus: notification.status ?? BookingStatus.notFound,
              onSuccess: onTapSuccess,
            ),
            // if (notification.status == BookingStatus.confirmed) ...[
            //   const VSpacer(AppDimensions.paddingLarge),
            //   _CompleteButton(
            //     notification: notification,
            //     onTap: onTap,
            //     isLoading: isLoading,
            //   ),
            // ],
            // if (notification.status == BookingStatus.waiting) ...[
            //   const VSpacer(AppDimensions.paddingLarge),
            //   _ConfirmButton(
            //     notification: notification,
            //     onTap: onTap,
            //     isLoading: isLoading,
            //   ),
            // ],
          ],
        ],
      ),
    );
  }
}

class _ClientInfoRow extends StatelessWidget {
  final MasterNotificationBookingDto notification;
  final TextStyle? headerTextTheme;
  final TextStyle? bodyTextTheme;
  final TextStyle bodyTextThemeBold;

  const _ClientInfoRow({
    required this.notification,
    required this.headerTextTheme,
    required this.bodyTextTheme,
    required this.bodyTextThemeBold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.client,
                style: headerTextTheme,
              ),
              Text(
                notification.client?.personFn ?? '',
                style: bodyTextThemeBold,
              ),
              const VSpacer(AppDimensions.paddingSmall),
              Text(
                "+993 ${notification.client?.phone ?? '--'}",
                style: bodyTextTheme,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ServicesColumn extends StatelessWidget {
  final MasterNotificationBookingDto notification;
  final TextStyle? headerTextTheme;
  final TextStyle? bodyTextTheme;
  final TextStyle bodyTextThemeBold;

  const _ServicesColumn({
    required this.notification,
    required this.headerTextTheme,
    required this.bodyTextTheme,
    required this.bodyTextThemeBold,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.services,
          style: headerTextTheme,
        ),
        Column(
          children: notification.services?.map((e) {
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.name ?? '',
                        style: bodyTextThemeBold,
                      ),
                    ),
                    const HSpacer(AppDimensions.paddingMedium),
                    Text(
                      '${e.price} TMT | ${FormatDurationHelper.getFormattedDuration(context, e.duration ?? 0)} ',
                      style: bodyTextTheme,
                    ),
                  ],
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }
}

class _DateRow extends StatelessWidget {
  final MasterNotificationBookingDto notification;
  final TextStyle? headerTextTheme;
  final TextStyle bodyTextThemeBold;

  const _DateRow({
    required this.notification,
    required this.headerTextTheme,
    required this.bodyTextThemeBold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.date,
                style: headerTextTheme,
              ),
              Text(
                '${DateFormat('d MMMM, (EE)', context.loc.localeName).format(
                  DateTime.parse(notification.date ?? ''),
                )} | ${notification.time}',
                style: bodyTextThemeBold,
              ),
            ],
          ),
        ),
        const HSpacer(AppDimensions.paddingMedium),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                AppDimensions.radiusLarge,
              ),
            ),
            border: Border.all(
              color: AppColors.black,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingSmall,
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Text(
            FormatDurationHelper.getFormattedDuration(
                context, notification.totalDuration ?? 0),
            style: bodyTextThemeBold,
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final MasterNotificationBookingDto notification;
  final TextStyle? headerTextTheme;
  final TextStyle bodyTextThemeBold;

  const _StatusRow({
    required this.notification,
    required this.headerTextTheme,
    required this.bodyTextThemeBold,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.status,
          style: headerTextTheme,
        ),
        Text(
          context.loc.booking_status(notification.status?.name ?? ''),
          style: bodyTextThemeBold,
        ),
      ],
    );
  }
}

class _BookingPaymentRow extends StatelessWidget {
  final MasterNotificationBookingDto notification;
  final TextStyle? headerTextTheme;
  final TextStyle bodyTextThemeBold;

  const _BookingPaymentRow({
    required this.notification,
    required this.headerTextTheme,
    required this.bodyTextThemeBold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.booking,
                style: headerTextTheme,
              ),
              Text(
                notification.notification?.id.toString() ?? '',
                style: bodyTextThemeBold,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.total_payment,
                style: headerTextTheme,
              ),
              Text(
                '${notification.totalPrice ?? 0} TMT',
                style: bodyTextThemeBold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final MasterNotificationBookingDto notification;

  const _ActionButtonsRow({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              if (notification.client == null) {
                return;
              }
              if (notification.client!.phone == null ||
                  notification.client!.phone!.isEmpty) {
                return;
              }
              URLLauncherHelper.phoneCall(notification.client!.phone);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: Text(context.loc.call_title),
          ),
        ),
        const HSpacer(AppDimensions.paddingLarge),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              if (notification.client == null) {
                return;
              }
              if (notification.client!.phone == null ||
                  notification.client!.phone!.isEmpty) {
                return;
              }
              URLLauncherHelper.sendSms(
                  notification.client!.phone, 'Hello there');
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: Text(context.loc.text_title),
          ),
        ),
      ],
    );
  }
}
