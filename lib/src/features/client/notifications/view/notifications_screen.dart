// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/notifications/controller/client_notification_booking_controller.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/utils/utils.dart';

import '../../../../widgets/widgets.dart';
import '../../../shared/shared.dart';

class ClientNotificationsScreen extends StatefulWidget {
  const ClientNotificationsScreen({super.key});

  @override
  State<ClientNotificationsScreen> createState() =>
      _ClientNotificationsScreenState();
}

class _ClientNotificationsScreenState extends State<ClientNotificationsScreen> {
  final controller = GetIt.instance<ClientNotificationBookingController>();

  @override
  void initState() {
    controller.setContext(context);
    controller.getBookingNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.notifications,
        isSliver: false,
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!controller.stateManager.isSuccess ||
              (controller.stateManager.isSuccess && controller.items.isEmpty)) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: controller.stateManager.isLoading,
                isError: controller.stateManager.isError,
                isEmpty: controller.items.isEmpty,
                emptyIcon: Icons.notifications_off_outlined,
                onError: () {
                  controller.getBookingNotifications();
                },
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    final notification = controller.items[index];
                    return NotificationItemWidget(
                      notificationDto: notification,
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const VSpacer(AppDimensions.paddingMedium);
                  },
                  itemCount: controller.items.length,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class NotificationItemWidget extends StatelessWidget {
  final NotificationBookingInfoDto notificationDto;

  const NotificationItemWidget({
    super.key,
    required this.notificationDto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusMedium),
        ),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const HSpacer(AppDimensions.paddingMedium),
              Expanded(
                child: Text(
                  notificationDto.client?.fullName ?? '',
                  style: context.textTheme.containerTitle,
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: BookingStatusWidget(
                    status: BookingStatus.fromJson(notificationDto.status?.id),
                  ),
                ),
              )
            ],
          ),
          const VSpacer(AppDimensions.paddingMedium),
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              const HSpacer(AppDimensions.paddingSmall),
              Text(
                DateFormat('d MMMM, (E.) | HH:mm', context.loc.localeName)
                    .format(
                  DateTime.parse(
                      "${notificationDto.date!} ${notificationDto.time!}"),
                ),
              ),
            ],
          ),
          const VSpacer(AppDimensions.paddingMedium),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    if (notificationDto.client!.phone == null ||
                        notificationDto.client!.phone!.isEmpty) {
                      return;
                    }
                    URLLauncherHelper.phoneCall(notificationDto.client!.phone);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Text(context.loc.call_title),
                ),
              ),
              const HSpacer(AppDimensions.paddingMedium),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      ClientRoutes.myBookings,
                    );
                  },
                  child: Text(context.loc.details),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookingStatusWidget extends StatelessWidget {
  final BookingStatus status;

  const BookingStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall,
        horizontal: AppDimensions.paddingMedium,
      ),
      child: Text(
        context.loc.booking_status(status.name),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: _getForegroundColor(context),
            ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (status == BookingStatus.reschedule) {
      return AppColors.yellow;
    }
    return Theme.of(context).colorScheme.onPrimary;
    // switch (status) {
    //   case BookingStatus.cancelled:
    //     return AppColors.red;
    //   case BookingStatus.confirmed:
    //     return AppColors.green;
    //   case BookingStatus.reschedule:
    //
    //   case BookingStatus.waiting:
    //     return AppColors.mediumGrey;
    // }
  }

  Color? _getForegroundColor(BuildContext context) {
    switch (status) {
      case BookingStatus.confirmed: // Подтверждено
        return AppColors.lightBlue;
      case BookingStatus.cancelled: // Отменено
        return AppColors.pink; // Используем красный для отмененных
      case BookingStatus.waiting: // В ожидании
        return AppColors.lightYellow;
      case BookingStatus.completed: // Завершена
        return AppColors.belleGray;
      case BookingStatus.reschedule: // Перенесена с отменой
        return AppColors
            .lightPink; // Используем красный для перенесенных с отменой
      case BookingStatus.clientArrived: // Перенесена с отменой
        return AppColors
            .lightGreen; // Используем красный для перенесенных с отменой
      default:
        return AppColors.belleGray; // По умолчанию серый
    }
  }
}
