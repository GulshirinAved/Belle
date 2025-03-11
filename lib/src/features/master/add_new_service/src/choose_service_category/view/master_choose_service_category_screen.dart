import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/widgets.dart';

class MasterChooseServiceCategoryScreen extends StatefulWidget {
  const MasterChooseServiceCategoryScreen({super.key});

  @override
  State<MasterChooseServiceCategoryScreen> createState() =>
      _MasterChooseServiceCategoryScreenState();
}

class _MasterChooseServiceCategoryScreenState
    extends State<MasterChooseServiceCategoryScreen> {
  final controller = GetIt.instance<ServicesController>();
  MasterType selectedType = MasterType.men;

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.choose_service_category),
        leadingWidth: 80.0,
        leading: StyledBackButton(
          onTap: () {
            context.pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium),
            child: AnimatedToggleWidget<MasterType?>(
              initialValue: MasterType.men,
              onChanged: (value) {
                controller.fetchServices(value?.id);
                selectedType = value!;
              },
              props: const AnimatedToggleWidgetProps(),
              items: [
                AnimatedToggleWidgetItem(
                  value: MasterType.men,
                  title: context.loc.for_men,
                ),
                AnimatedToggleWidgetItem(
                  value: MasterType.women,
                  title: context.loc.for_women,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Observer(
          builder: (context) {
            if (!controller.stateManager.isSuccess) {
              return StateControlWidget(
                props: StateControlWidgetProps(
                  isLoading: controller.stateManager.isLoading,
                  isError: controller.stateManager.isError,
                  onError: () {
                    controller.fetchServices();
                  },
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      StyledBackgroundContainer(
                        child: StyledContainerWithColumn(
                          items: controller.items
                              .map(
                                (item) => StyledItemWidget(
                                    onTap: () {
                                      context.pushNamed(
                                        MasterRoutes.chooseService,
                                        extra:
                                            MasterChooseServiceCategoryRouteModel(
                                          serviceId: item.id ?? 0,
                                          serviceName: item.name ?? '',
                                          genderId: selectedType.id,
                                        ),
                                      );
                                    },
                                    title: item.name ?? ''),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class StyledItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color? textColor;
  final Color? iconColor;

  const StyledItemWidget(
      {super.key,
      required this.onTap,
      required this.title,
      this.textColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
          horizontal: AppDimensions.paddingMedium,
        ),
        child: TitleWithIconRow(
          title: title,
          icon: Icons.arrow_forward_ios_rounded,
          textColor: textColor,
          iconColor: iconColor,
        ),
      ),
    );
  }
}
