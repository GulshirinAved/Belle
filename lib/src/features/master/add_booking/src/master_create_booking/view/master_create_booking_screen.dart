import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../widgets/widgets.dart';

class MasterCreateBookingScreen extends StatefulWidget {
  final MasterCreateBookingDto? data;

  const MasterCreateBookingScreen({
    super.key,
    required this.data,
  });

  @override
  State<MasterCreateBookingScreen> createState() =>
      _MasterCreateBookingScreenState();
}

class _MasterCreateBookingScreenState extends State<MasterCreateBookingScreen> {
  final controller = GetIt.instance<MasterCreateBookingController>();

  @override
  void initState() {
    controller.setContext(context);
    super.initState();
  }

  String calculateTotalDuration(List<MasterOwnSubserviceDto>? services) {
    if (services == null || services.isEmpty) {
      return '';
    }
    double durationInMinutes = 0.0;
    for (var service in services) {
      durationInMinutes += service.time ?? 0;
    }
    final totalDuration = FormatDurationHelper.getFormattedDuration(
        context, durationInMinutes.toInt());
    return totalDuration;
  }

  double calculateTotalPrice(List<MasterOwnSubserviceDto>? services) {
    if (services == null || services.isEmpty) {
      return 0.0;
    }
    double price = 0.0;
    for (var service in services) {
      price += service.prices?.fix ?? service.prices?.min ?? 0;
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data!;

    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.booking,
        isSliver: false,
      ),
      bottomNavigationBar: SafeArea(
        child: StyledBackgroundContainer(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${context.loc.total_payment} ${context.loc.from}: ${calculateTotalPrice(data.subservices).toStringAsFixed(2)} TMT',
                    style: context.textTheme.containerTitle,
                  ),
                ),
                Text(calculateTotalDuration(data.subservices)),
              ],
            ),
            const VSpacer(AppDimensions.paddingLarge),
            Observer(
              builder: (context) {
                return ElevatedButtonWithState(
                  onPressed: () async {
                    await controller.makeBooking(data);
                    if (!controller.stateManager.isSuccess) {
                      return;
                    }
                    if (!context.mounted) {
                      return;
                    }
                    context.goNamed(MasterRoutes.home);
                  },
                  isLoading: controller.stateManager.isLoading,
                  child: Text(context.loc.confirm),
                );
              },
            ),
          ],
        )),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            StyledBackgroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppDimensions.paddingMedium,
                children: [
                  StyledContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingMedium,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.loc.date,
                          style: context.textTheme.containerTitle,
                        ),
                        Text(
                            '${DateFormat('d MMMM, (EE)', context.loc.localeName).format(
                          DateTime.parse(data.date ?? ''),
                        )} | ${data.time}'),
                      ],
                    ),
                  ),
                  StyledContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingMedium,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.loc.client,
                          style: context.textTheme.containerTitle,
                        ),
                        Text(data.clientName ?? ''),
                      ],
                    ),
                  ),
                  Text(context.loc.services),
                  StyledContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingMedium,
                    ),
                    child: Column(
                      children: data.subservices?.map(
                            (e) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppDimensions.paddingExtraSmall,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            e.name ?? '',
                                            style: context
                                                .textTheme.containerTitle,
                                          ),
                                        ),
                                        // const Spacer(),
                                        Text(
                                          '${e.prices?.fix ?? '${e.prices?.min}-${e.prices?.max}'} TMT | ${e.time} ${context.loc.minute_short}',
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (data.subservices?.indexOf(e) !=
                                      (data.subservices?.length ?? 1) - 1) ...[
                                    const Divider(),
                                  ]
                                ],
                              );
                            },
                          ).toList() ??
                          [],
                    ),
                  ),
                ],
              ),
            ),
            const VSpacer(AppDimensions.paddingMedium),
          ],
        ),
      ),
    );
  }
}
