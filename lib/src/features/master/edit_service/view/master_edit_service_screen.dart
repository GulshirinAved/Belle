import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class MasterEditServiceScreen extends StatefulWidget {
  final MasterServiceDto data;

  const MasterEditServiceScreen({
    super.key,
    required this.data,
  });

  @override
  State<MasterEditServiceScreen> createState() =>
      _MasterEditServiceScreenState();
}

class _MasterEditServiceScreenState extends State<MasterEditServiceScreen> {
  final controller = GetIt.instance<MasterEditServiceController>();
  final stateController = GetIt.instance<MasterEditServiceStateController>();

  final key = GlobalKey<FormState>();

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
    stateController.setupData(widget.data);
    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();
    key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.edit_service,
        isSliver: false,
      ),
      bottomNavigationBar: SafeArea(
        child: StyledBackgroundContainer(
          child: Row(
            spacing: AppDimensions.paddingMedium,
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      useSafeArea: true,
                      builder: (context) {
                        return DeleteServiceBottomSheetBody(
                          onDelete: () {
                            controller.deleteService(
                              widget.data.id ?? 0,
                              () {
                                this.context.pop(true);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: Text(context.loc.delete),
                ),
              ),
              Expanded(
                flex: 3,
                child: Observer(builder: (context) {
                  return ElevatedButtonWithState(
                    isLoading: controller.stateManager.isLoading,
                    onPressed: () {
                      if (!(key.currentState!.validate())) {
                        return;
                      }
                      final data = stateController.generateData();
                      controller.editService(
                        data,
                        () => context.pop(true),
                      );
                    },
                    child: Text(context.loc.save),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          StyledBackgroundContainer(
            child: Form(
              key: key,
              child: Column(
                spacing: AppDimensions.paddingMedium,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Observer(builder: (context) {
                    return UniversalPickerWidget<SubserviceDto>(
                      onTap: (onTapContext) {},
                      selectedValue: stateController.chosenSubservice,
                      title: context.loc.service_name,
                      content:
                          Text(stateController.chosenSubservice?.name ?? ''),
                      required: true,
                    );
                  }),
                  StandardInputField(
                    props: StandardInputFieldProps(
                      textEditingController: stateController.commentController,
                      labelText: context.loc.service_description,
                      validator: ValidationBuilder(
                        optional: true,
                      ).minLength(3).build(),
                    ),
                  ),
                  Observer(builder: (context) {
                    return UniversalPickerWidget<int>(
                      onTap: (onTapContext) {
                        showCupertinoModalPopup(
                            context: onTapContext,
                            builder: (_) => DurationPickerWidget(
                                initialItem:
                                    stateController.subserviceDuration ?? 0,
                                onSelectedItemChanged: (value) =>
                                    stateController
                                        .changeSubserviceDuration(value)));
                      },
                      selectedValue: stateController.subserviceDuration,
                      title: context.loc.service_duration,
                      content: _getFormattedDuration(
                          (stateController.subserviceDuration ?? -1)),
                      required: true,
                    );
                  }),
                  const Divider(),
                  Text(
                    '${context.loc.price} TMT',
                    style: context.textTheme.appTitle,
                  ),
                  Observer(builder: (context) {
                    return AnimatedToggleWidget<bool>(
                      initialValue: stateController.isPriceFixed,
                      onChanged: (bool value) {
                        stateController.togglePriceFixed(value);
                      },
                      items: [
                        AnimatedToggleWidgetItem(
                          value: true,
                          title: context.loc.fixed_price,
                        ),
                        AnimatedToggleWidgetItem(
                          value: false,
                          title: context.loc.price_range,
                        ),
                      ],
                      props: const AnimatedToggleWidgetProps(),
                    );
                  }),
                  Observer(builder: (context) {
                    if (stateController.isPriceFixed) {
                      return StandardInputField(
                        props: StandardInputFieldProps(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          labelText: context.loc.fixed_price,
                          validator: ValidationBuilder(
                            optional: !stateController.isPriceFixed,
                            localeName: context.loc.localeName,
                          ).build(),
                          textEditingController:
                              stateController.fixedPriceController,
                        ),
                      );
                    }
                    return Row(
                      spacing: AppDimensions.paddingMedium,
                      children: [
                        Expanded(
                          child: StandardInputField(
                            props: StandardInputFieldProps(
                              validator: ValidationBuilder(
                                optional: stateController.isPriceFixed ||
                                    stateController
                                        .maxPriceController.text.isNotEmpty,
                                localeName: context.loc.localeName,
                              ).build(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: context.loc.min_price,
                              textEditingController:
                                  stateController.minPriceController,
                            ),
                          ),
                        ),
                        Expanded(
                          child: StandardInputField(
                            props: StandardInputFieldProps(
                              keyboardType: TextInputType.number,
                              validator: ValidationBuilder(
                                optional: stateController.isPriceFixed ||
                                    stateController
                                        .minPriceController.text.isNotEmpty,
                                localeName: context.loc.localeName,
                              ).build(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: context.loc.max_price,
                              textEditingController:
                                  stateController.maxPriceController,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          const VSpacer(AppDimensions.paddingMedium),
        ],
      ),
    );
  }

  Widget _getFormattedDuration(int index) {
    return Text(FormatDurationHelper.getFormattedDurationByIndex(index));
  }
}

class DeleteServiceBottomSheetBody extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteServiceBottomSheetBody({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StyledBackgroundContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppDimensions.paddingMedium,
          children: [
            Row(
              spacing: AppDimensions.paddingMedium,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Theme.of(context).colorScheme.error,
                  size: 68.9,
                ),
                Column(
                  spacing: AppDimensions.paddingSmall,
                  children: [
                    Text(
                      context.loc.delete_service,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(context.loc.delete_service_desc),
                  ],
                ),
              ],
            ),
            Row(
              spacing: AppDimensions.paddingMedium,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(context.loc.no),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onDelete();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: Text(context.loc.yes),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
