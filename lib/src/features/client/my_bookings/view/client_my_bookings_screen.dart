// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/client/my_bookings/controller/client_my_bookings_controller.dart';
import 'package:belle/src/utils/utils.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../../shared/shared.dart';

class ClientMyBookingsScreen extends StatefulWidget {
  const ClientMyBookingsScreen({
    super.key,
  });

  @override
  State<ClientMyBookingsScreen> createState() => _ClientMyBookingsScreenState();
}

class _ClientMyBookingsScreenState extends State<ClientMyBookingsScreen> {
  final controller = GetIt.instance<ClientMyBookingsController>();
  final statusController = GetIt.instance<ClientBookingStatusController>();

  final stateController = GetIt.instance<ClientMyBookingsStateController>();

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);

    controller.fetchMyBookings(stateController.currentBookingType);

    super.initState();
  }

  @override
  void dispose() {
    controller.disposeContext();
    stateController.disposeContext();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await controller
            .fetchMyBookings(stateController.currentBookingType),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(context.loc.my_bookings),
              pinned: true,
              leadingWidth: 100.0,
              leading: StyledBackButton(onTap: () {
                context.pop();
              }),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                    vertical: AppDimensions.paddingMedium,
                  ),
                  child: Observer(builder: (context) {
                    return AnimatedToggleWidget<ClientBookingType>(
                      initialValue: ClientBookingType.active,
                      onChanged: (value) {
                        if (controller.stateManager.isLoading) {
                          return;
                        }
                        stateController.changeCurrentBookingType(value,
                            (value) {
                          controller.fetchMyBookings(value);
                        });
                      },
                      props: AnimatedToggleWidgetProps<ClientBookingType>(
                        selectedValue: stateController.currentBookingType,
                      ),
                      items: [
                        AnimatedToggleWidgetItem(
                          value: ClientBookingType.active,
                          title: context.loc.active,
                        ),
                        AnimatedToggleWidgetItem(
                          value: ClientBookingType.history,
                          title: context.loc.history,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingLarge,
              ),
              sliver: Observer(builder: (context) {
                switch (stateController.currentBookingType) {
                  case ClientBookingType.active:
                    if (!(controller.stateManager.isSuccess) ||
                        (controller.stateManager.isSuccess &&
                            controller.items.isEmpty)) {
                      return StateControlWidget(
                        props: StateControlWidgetProps(
                            isEmpty: controller.items.isEmpty,
                            isError: controller.stateManager.isError,
                            isLoading: controller.stateManager.isLoading,
                            isSliver: true,
                            emptyIcon: Icons.calendar_today_outlined,
                            emptyTitle: context.loc.no_bookings,
                            onError: () {
                              controller.fetchMyBookings(
                                  stateController.currentBookingType);
                            }),
                      );
                    }
                    return SliverList.separated(
                      itemBuilder: (context, index) {
                        final clientBookingsDto = controller.items[index];
                        return MyBookingStatusWidget(
                          clientBookingsDto: clientBookingsDto,
                          // chosenServicesToSendDto:
                          // stateController.chosenServicesToSendDto!,
                          bookingType: BookingType.reschedule,
                        );
                      },
                      itemCount: controller.items.length,
                      separatorBuilder: (_, __) {
                        return const VSpacer(AppDimensions.paddingLarge);
                      },
                    );
                  case ClientBookingType.history:
                    if (!(controller.stateManager.isSuccess) ||
                        (controller.stateManager.isSuccess &&
                            controller.items.isEmpty)) {
                      return StateControlWidget(
                        props: StateControlWidgetProps(
                            isEmpty: controller.items.isEmpty,
                            isError: controller.stateManager.isError,
                            isLoading: controller.stateManager.isLoading,
                            emptyIcon: Icons.calendar_today_outlined,
                            emptyTitle: context.loc.no_bookings,
                            isSliver: true,
                            onError: () {
                              controller.fetchMyBookings(
                                  stateController.currentBookingType);
                            }),
                      );
                    }
                    return SliverList.separated(
                      itemBuilder: (context, index) {
                        final clientBookingsDto = controller.items[index];
                        return MyBookingStatusWidget(
                          clientBookingsDto: clientBookingsDto,
                          bookingType: BookingType.reschedule,
                        );
                      },
                      itemCount: controller.items.length,
                      separatorBuilder: (_, __) {
                        return const VSpacer(AppDimensions.paddingLarge);
                      },
                    );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

//my bookings card
class MyBookingStatusWidget extends StatefulWidget {
  final ClientBookingsDto clientBookingsDto;

  final BookingType bookingType;

  const MyBookingStatusWidget({
    super.key,
    required this.clientBookingsDto,
    required this.bookingType,
  });

  @override
  State<MyBookingStatusWidget> createState() => _MyBookingStatusWidgetState();
}

class _MyBookingStatusWidgetState extends State<MyBookingStatusWidget> {
  final controller = GetIt.instance<ClientMyBookingsController>();

  final stateController = GetIt.instance<ClientMyBookingsStateController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusLarge),
        ),
        border: Border.all(
          color: BookingColors.getMainColor(
              widget.clientBookingsDto.status, context),
          width: 5.0,
        ),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StatusComponent(
            status: widget.clientBookingsDto.status,
            bookingNumber: widget.clientBookingsDto.bookingNumber ?? 0,
          ),
          if (widget.clientBookingsDto.status == BookingStatus.reschedule) ...[
            const VSpacer(AppDimensions.paddingLarge),
            Text(
              'No. #${widget.clientBookingsDto.bookingNumber ?? 0}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            constraints: const BoxConstraints(
              minHeight: 150.0,
              maxHeight: 260.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: BookingInfoComponent(
                          icon: Icons.style_outlined,
                          title: getServicesNames(
                              widget.clientBookingsDto.services ?? []),
                          size: BookingInfoComponentSize.big,
                        ),
                      ),
                      const VerticalDivider(
                        indent: 0.0,
                        endIndent: 0.0,
                      ),
                      Expanded(
                        child: BookingInfoComponent(
                          icon: Icons.account_circle_outlined,
                          title:
                              widget.clientBookingsDto.master?.fullName ?? '',
                          size: BookingInfoComponentSize.big,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.0,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: BookingInfoComponent(
                          icon: Icons.calendar_month_outlined,
                          title: widget.clientBookingsDto.date ?? '',
                          size: BookingInfoComponentSize.small,
                        ),
                      ),
                      const VerticalDivider(
                        indent: 0.0,
                        endIndent: 0.0,
                      ),
                      Expanded(
                        child: BookingInfoComponent(
                          icon: Icons.monetization_on_outlined,
                          title: '${widget.clientBookingsDto.totalPrice} TMT',
                          size: BookingInfoComponentSize.small,
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: BookingInfoComponent(
                          icon: Icons.location_on_outlined,
                          title: widget.clientBookingsDto.address ?? '',
                          size: BookingInfoComponentSize.small,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.bookingType == BookingType.reschedule) ...{
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      stateController.setContext(context);
                      stateController
                          .showCancel(widget.clientBookingsDto.bookingNumber);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: Text(context.loc.cancel),
                  ),
                  const HSpacer(AppDimensions.paddingMedium),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushNamed(
                          ClientRoutes.reschedule,
                          extra: widget.clientBookingsDto,
                        );
                      },
                      child: Text(context.loc.reschedule),
                    ),
                  ),
                ],
              ),
            )
          }
        ],
      ),
    );
  }

  String getServicesNames(List<Services> services) {
    String name = '';
    for (final service in services) {
      if (service.name == null || service.name?.length == 0) {
        continue;
      }
      if (services.indexOf(service) == services.length - 1) {
        name += service.name ?? '';
        break;
      }
      name += service.name ?? '';
      name += ', ';
    }
    return name;
  }
}

class StatusComponent extends StatelessWidget {
  final BookingStatus status;
  final int bookingNumber;

  const StatusComponent(
      {super.key, required this.status, required this.bookingNumber});

  @override
  Widget build(BuildContext context) {
    if (status == BookingStatus.reschedule) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.yellow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusSmall),
            topRight: Radius.circular(AppDimensions.radiusSmall),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingLarge,
          horizontal: AppDimensions.paddingExtraLarge,
        ),
        child: Text(
          context.loc.booking_status(status.name),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: BookingColors.getSecondaryColor(status, context),
              ),
        ),
      );
    }
    return Row(
      children: [
        const HSpacer(AppDimensions.paddingLarge),
        Expanded(
          child: Text(
            'No. #$bookingNumber',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: BookingColors.getMainColor(status, context),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppDimensions.radiusLarge),
              topRight: Radius.circular(AppDimensions.radiusSmall),
            ),
          ),
          padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingLarge,
              horizontal: AppDimensions.paddingExtraLarge),
          child: Text(
            context.loc.booking_status(status.name),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: BookingColors.getSecondaryColor(status, context),
                ),
          ),
        ),
      ],
    );
  }
}

enum BookingType {
  reschedule,
  normal,
}

class CancelBookingWidget extends StatefulWidget {
  final int bookingNumber;

  const CancelBookingWidget({super.key, required this.bookingNumber});

  @override
  State<CancelBookingWidget> createState() => _CancelBookingWidgetState();
}

class _CancelBookingWidgetState extends State<CancelBookingWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance<ClientBookingStatusController>();
    final textTheme = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.error, size: 53, color: AppColors.red),
              const HSpacer(6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.cancel_booking,
                      style: textTheme?.copyWith(fontSize: 20),
                    ),
                    Text(context.loc.confirm_cancel_booking),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Text(context.loc.return_text, style: textTheme),
                ),
                const HSpacer(AppDimensions.paddingMedium),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.setContext(context);
                      await controller.changeStatus(widget.bookingNumber, 2,
                          () {
                        log('it is success');
                        _success();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        surfaceTintColor: AppColors.red),
                    child: Text(context.loc.cancel, style: textTheme),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _success() {
    if (!mounted) return;
    ShowSnackHelper.showSnack(
      context,
      SnackStatus.success,
      context.loc.snack_title('success'),
    );
    context.pop();
  }
}

class BookingInfoComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final BookingInfoComponentSize size;

  const BookingInfoComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: _getIconSize()),
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  double _getIconSize() {
    switch (size) {
      case BookingInfoComponentSize.big:
        return 35.0;
      case BookingInfoComponentSize.small:
        return 24.0;
      // default:
      //   return 24.0;
    }
  }
}

enum BookingInfoComponentSize {
  small,
  big,
}

class BookingColors {
  static Color getMainColor(BookingStatus status, BuildContext context) {
    switch (status) {
      case BookingStatus.cancelled:
        return AppColors.red;
      case BookingStatus.confirmed:
        return AppColors.lightGreen;
      case BookingStatus.reschedule:
        return AppColors.yellow;
      case BookingStatus.waiting:
        return AppColors.orange;
      case BookingStatus.completed:
        return Theme.of(context).colorScheme.primary;
      default:
        return AppColors.gray;
    }
  }

  static Color getSecondaryColor(BookingStatus status, BuildContext context) {
    switch (status) {
      case BookingStatus.reschedule:
        return AppColors.black;
      default:
        return AppColors.white;
    }
  }
}
