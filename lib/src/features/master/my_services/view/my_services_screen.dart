import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class MasterMyServicesScreen extends StatefulWidget {
  const MasterMyServicesScreen({super.key});

  @override
  State<MasterMyServicesScreen> createState() => _MasterMyServicesScreenState();
}

class _MasterMyServicesScreenState extends State<MasterMyServicesScreen> {
  final controller = GetIt.instance<MasterMyServicesController>();
  final stateController = GetIt.instance<MasterMyServicesStateController>();
  final editController = GetIt.instance<MasterMyServicesEditController>();

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
    editController.setContext(context);
    controller.fetchServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.my_services,
        isSliver: false,
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!controller.stateManager.isSuccess ||
              (controller.stateManager.isSuccess && controller.items.isEmpty)) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                isError: controller.stateManager.isError,
                isLoading: controller.stateManager.isLoading,
                isEmpty: controller.items.isEmpty,
                onError: () {
                  controller.fetchServices();
                },
              ),
            );
          }
          stateController.init(controller.items);

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingMedium,
                  horizontal: AppDimensions.paddingLarge,
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    final service = controller.items[index];
                    return Observer(builder: (context) {
                      return MasterServiceItemWidget(
                        service: service,
                        onMakeMainTap: (value) {
                          stateController.setMainId(value);
                        },
                        onEditTap: () async {
                          final needUpdate = await context.pushNamed<bool?>(
                              MasterRoutes.editService,
                              extra: service);

                          if (needUpdate == null) {
                            return;
                          }
                          if (needUpdate) {
                            controller.fetchServices();
                          }
                        },
                        isMainId: stateController.isMainId,
                      );
                    });
                  },
                  itemCount: controller.items.length,
                  separatorBuilder: (_, __) {
                    return const VSpacer(AppDimensions.paddingMedium);
                  },
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final needUpdate =
              await context.pushNamed<bool?>(MasterRoutes.addNewService);
          if (needUpdate == null) {
            return;
          }
          if (needUpdate) {
            controller.fetchServices();
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SafeArea(
        child: Observer(builder: (context) {
          if (!controller.stateManager.isSuccess ||
              (controller.stateManager.isSuccess && controller.items.isEmpty)) {
            return const SizedBox();
          }
          return StyledBackgroundContainer(
            child: ElevatedButtonWithState(
              onPressed: stateController.isMainId ==
                      stateController.initialIndex
                  ? null
                  : () {
                      editController.saveMainService(stateController.isMainId);
                    },
              isLoading: editController.stateManager.isLoading,
              child: Text(context.loc.save),
            ),
          );
        }),
      ),
    );
  }
}

class MasterServiceItemWidget extends StatelessWidget {
  final MasterServiceDto service;
  final ValueChanged<int?> onMakeMainTap;
  final int? isMainId;
  final VoidCallback onEditTap;

  const MasterServiceItemWidget({
    super.key,
    required this.service,
    required this.onMakeMainTap,
    required this.isMainId,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        border: Border.all(
          color: colorScheme.secondary,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppDimensions.radiusMedium,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        // horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingMedium,
      ),
      child: Column(
        // spacing: AppDimensions.paddingMedium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Text(
              service.subserviceName ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.appTitle,
            ),
          ),
          const VSpacer(AppDimensions.paddingSmall),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Row(
              spacing: AppDimensions.paddingLarge,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ServiceItemTitleAndContentWidget(
                  key: ValueKey('${service.id} | time'),
                  title: context.loc.time,
                  content: Text(
                    FormatDurationHelper.getFormattedDuration(
                        context, service.time ?? 0),
                    style: context.textTheme.containerTitle,
                  ),
                ),
                _ServiceItemTitleAndContentWidget(
                  key: ValueKey('${service.id} | price'),
                  title: context.loc.price,
                  content: _ServiceItemPriceWidget(
                    fixedPrice: service.fixPrice,
                    minPrice: service.minPrice,
                    maxPrice: service.maxPrice,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Radio<int?>(
                value: service.subserviceId,
                groupValue: isMainId,
                visualDensity: VisualDensity.compact,
                splashRadius: 0.0,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  onMakeMainTap(service.subserviceId);
                },
              ),
              GestureDetector(
                onTap: () {
                  onMakeMainTap(service.subserviceId);
                },
                child: Text(
                  isMainId == service.subserviceId
                      ? context.loc.main_profile
                      : context.loc.make_main,
                  style: textTheme.titleSmall?.copyWith(
                    color:
                        0 == service.subserviceId ? colorScheme.primary : null,
                  ),
                ),
              ),
              const Spacer(),
              EditButton(onEditTap: onEditTap),
              const HSpacer(AppDimensions.paddingMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final VoidCallback onEditTap;
  final bool isBackgroundTransparent;

  const EditButton({
    super.key,
    required this.onEditTap,
    this.isBackgroundTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      width: 45.0,
      child: OutlinedButton(
        onPressed: onEditTap,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimensions.radiusMedium),
            ),
          ),
          backgroundColor: isBackgroundTransparent ? Colors.transparent : null,
        ),
        child: const Icon(
          Icons.edit_outlined,
          size: 19.0,
        ),
      ),
    );
  }
}

class _ServiceItemTitleAndContentWidget extends StatelessWidget {
  final String title;
  final Widget content;

  const _ServiceItemTitleAndContentWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimensions.paddingExtraSmall,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
        ),
        content,
      ],
    );
  }
}

class _ServiceItemPriceWidget extends StatelessWidget {
  final int? fixedPrice;
  final int? minPrice;
  final int? maxPrice;

  const _ServiceItemPriceWidget({
    this.fixedPrice,
    this.minPrice,
    this.maxPrice,
  });

  @override
  Widget build(BuildContext context) {
    final priceStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        );

    if (fixedPrice != null) {
      return Text(
        '$fixedPrice TMT',
        style: priceStyle,
      );
    }

    if (minPrice == null && maxPrice == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (minPrice != null) ...[
          _MinMaxPriceTitleWidget(
            title: context.loc.from,
            price: minPrice,
          ),
        ],
        if (maxPrice != null) ...[
          _MinMaxPriceTitleWidget(
            title: context.loc.to,
            price: maxPrice,
          ),
        ],
      ],
    );
  }
}

class _MinMaxPriceTitleWidget extends StatelessWidget {
  final int? price;
  final String title;

  const _MinMaxPriceTitleWidget({this.price, required this.title});

  @override
  Widget build(BuildContext context) {
    final priceStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        );
    return Row(
      spacing: AppDimensions.paddingSmall,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text('$price TMT', style: priceStyle),
      ],
    );
  }
}
