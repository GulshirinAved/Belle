import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/core.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/widgets.dart';
import '../../../../master.dart';

class MasterServicesScreen extends StatefulWidget {
  final String? time;
  final List<int>? chosenServices;
  final List<MasterOwnSubserviceDto>? chosenServicesList;

  const MasterServicesScreen({
    super.key,
    this.time,
    this.chosenServices,
    this.chosenServicesList,
  });

  @override
  State<MasterServicesScreen> createState() => _MasterServicesScreenState();
}

class _MasterServicesScreenState extends State<MasterServicesScreen> {
  final infoController = GetIt.instance<MasterServicesController>();
  final controller = GetIt.instance<MasterServicesStateController>();

  @override
  void initState() {
    infoController.setContext(context);
    infoController.fetchOwnServices(
        time: widget.time,
        onSuccess: () {
          controller.initData(
            infoController.items,
            widget.time,
            context,
            widget.chosenServices ?? <int>[],
          );
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithStyledLeading(
        title: '',
        isSliver: false,
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!infoController.stateManager.isSuccess) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: infoController.stateManager.isLoading,
                isError: infoController.stateManager.isError,
                isEmpty: infoController.items.isEmpty,
                onError: () {
                  infoController.fetchOwnServices(
                      time: widget.time,
                      onSuccess: () {
                        controller.initData(
                          infoController.items,
                          widget.time,
                          context,
                          widget.chosenServices ?? <int>[],
                        );
                      });
                },
                // isSliver: true,
              ),
            );
          }
          // final master = controller.data;
          final services = infoController.items;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: MasterInfoHorizontalCategoriesList(
                  onServiceTap: (value) {
                    controller.changeCurrentSelectedServiceId(value);
                  },
                  services: services,
                  selectedServiceId: controller.selectedServiceId,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge),
                sliver: MasterServicesTab(
                  onChooseTap: (value) {
                    controller.chooseService(value);
                  },
                  chosenServices: controller.chosenServices,
                  subservices: controller.subservices,
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: Observer(builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium),
            child: ElevatedButton(
              onPressed: controller.chosenServices.isEmpty
                  ? null
                  : () {
                      final data = controller.handleOnContinue();
                      context.pushNamed(
                        MasterRoutes.masterBookingClients,
                        extra: data,
                      );
                    },
              child: Text(
                context.loc.client,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MasterInfoHorizontalCategoriesList extends StatelessWidget {
  final List<MasterOwnServicesDto>? services;
  final ValueChanged<int?> onServiceTap;
  final int? selectedServiceId;

  const MasterInfoHorizontalCategoriesList({
    super.key,
    this.services,
    required this.onServiceTap,
    required this.selectedServiceId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services?.length ?? 0,
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
        separatorBuilder: (_, __) {
          return const HSpacer(AppDimensions.paddingMedium);
        },
        itemBuilder: (context, index) {
          final element = services?[index];
          final isSelected = element?.serviceId == selectedServiceId;
          return GestureDetector(
            onTap: () {
              onServiceTap(element?.serviceId);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.radiusMedium),
                ),
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
              margin: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingMedium),
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingMedium,
                horizontal: AppDimensions.paddingSmall +
                    AppDimensions.paddingExtraSmall,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (element?.serviceId == -1) ...[
                    const Icon(Icons.category_outlined),
                  ] else ...[
                    const SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CachingSVGImage(null)),
                  ],
                  const HSpacer(AppDimensions.paddingSmall),
                  Text(
                    element?.name ?? '',
                    style: context.textTheme.containerTitle,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MasterServicesTab extends StatelessWidget {
  final ValueChanged<int?> onChooseTap;
  final List<int?> chosenServices;
  final List<MasterOwnSubserviceDto> subservices;

  const MasterServicesTab({
    super.key,
    required this.onChooseTap,
    required this.chosenServices,
    required this.subservices,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: subservices.length,
      itemBuilder: (context, index) {
        final service = subservices[index];
        final isAvailable = service.isAvailable == true;
        return Opacity(
          opacity: isAvailable ? 1 : 0.5,
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimensions.radiusMedium),
              ),
            ),
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name ?? '',
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                          '${service.time} min - ${service.prices?.fix ?? '${service.prices?.min ?? 0}-${(service.prices?.max ?? 0)}'} TMT'),
                    ],
                  ),
                ),
                const HSpacer(AppDimensions.paddingLarge),
                Expanded(
                  child: Observer(builder: (context) {
                    void func() {
                      onChooseTap(service.subserviceId);
                    }

                    if (chosenServices.contains(service.subserviceId)) {
                      return ElevatedButton(
                        onPressed: !isAvailable ? null : func,
                        child: Text(context.loc.chosen),
                      );
                    }
                    return OutlinedButton(
                      onPressed: !isAvailable ? null : func,
                      child: Text(context.loc.choose),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
