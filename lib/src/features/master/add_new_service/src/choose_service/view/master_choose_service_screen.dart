import 'package:belle/src/core/core.dart';
import 'package:belle/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../theme/theme.dart';
import '../../../../master.dart';

class MasterChooseServiceScreen extends StatefulWidget {
  final String? name;
  final int? serviceId;
  final int? genderId;

  const MasterChooseServiceScreen({
    super.key,
    this.name,
    this.serviceId,
    this.genderId,
  });

  @override
  State<MasterChooseServiceScreen> createState() =>
      _MasterChooseServiceScreenState();
}

class _MasterChooseServiceScreenState extends State<MasterChooseServiceScreen> {
  final controller = GetIt.instance<MasterChooseServiceController>();

  int serviceId = -1;

  @override
  void initState() {
    controller.setContext(context);
    controller.init(widget.serviceId, widget.genderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: widget.name ?? '',
        isSliver: false,
      ),
      body: SafeArea(
        child: Observer(
          builder: (context) {
            final isItemsEmpty = controller.items.isEmpty;
            bool isEmpty = true;
            if (!isItemsEmpty) {
              isEmpty = controller.items.first.subservices?.isEmpty ?? false;
            }
            if (!controller.stateManager.isSuccess ||
                (controller.stateManager.isSuccess && isEmpty)) {
              return StateControlWidget(
                props: StateControlWidgetProps(
                  isError: controller.stateManager.isError,
                  isLoading: controller.stateManager.isLoading,
                  isEmpty: isEmpty,
                  onError: () {
                    controller.refresh();
                  },
                ),
              );
            }
            final subservices = controller.items.first.subservices ?? [];
            return Column(
              children: [
                const Spacer(),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                    ),
                    child: StyledContainerWithColumn(
                      items: subservices.map(
                        (item) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile<int?>(
                                value: item.id,
                                groupValue: serviceId,
                                visualDensity: VisualDensity.compact,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: AppDimensions.paddingExtraSmall,
                                  horizontal: AppDimensions.paddingMedium,
                                ),
                                splashRadius: 0.0,
                                dense: true,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Text(item.name ?? ''),
                                onChanged: (value) {
                                  if (serviceId == value) {
                                    return;
                                  }
                                  serviceId = value ?? 0;
                                  GoRouter.of(context).popUntil(
                                      MasterRoutes.addNewService, item);
                                },
                              ),
                              const Divider(
                                height: 0.0,
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                const VSpacer(AppDimensions.paddingMedium),
              ],
            );
          },
        ),
      ),
    );
  }
}
