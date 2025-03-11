import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:belle/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../theme/theme.dart';

class MasterAddNewServiceScreen extends StatefulWidget {
  const MasterAddNewServiceScreen({super.key});

  @override
  State<MasterAddNewServiceScreen> createState() =>
      _MasterAddNewServiceScreenState();
}

class _MasterAddNewServiceScreenState extends State<MasterAddNewServiceScreen> {
  final controller = GetIt.instance<MasterAddNewServiceController>();
  final stateController = GetIt.instance<MasterAddNewServiceStateController>();

  final key = GlobalKey<FormState>();

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
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
        title: context.loc.add_services,
        isSliver: false,
      ),
      bottomNavigationBar: SafeArea(
        child: StyledBackgroundContainer(
          child: Observer(builder: (context) {
            return ElevatedButtonWithState(
              isLoading: controller.stateManager.isLoading,
              onPressed: () {
                if (!(key.currentState!.validate())) {
                  return;
                }
                final data = stateController.generateData();
                controller.createNewService(data, () => context.pop(true));
              },
              child: Text(context.loc.save),
            );
          }),
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
                      onTap: (onTapContext) async {
                        final data = await context.pushNamed<SubserviceDto?>(
                            MasterRoutes.chooseServiceCategory);
                        if (data == null) {
                          return;
                        }
                        stateController.changeChosenSubservice(data);
                      },
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

class UniversalPickerWidget<T> extends StatelessWidget {
  final T? selectedValue;
  final String title;
  final Widget content;
  final bool required;
  final Function(BuildContext context) onTap;

  const UniversalPickerWidget({
    super.key,
    required this.selectedValue,
    required this.title,
    required this.content,
    required this.onTap,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          onTap(context);
        },
        child: FormField(
          validator: (_) {
            if (required && selectedValue == null) {
              return context.loc.required;
            }
            return null;
          },
          builder: (state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: title,
                suffixIcon: const Icon(Icons.arrow_forward_ios_rounded),
                errorText: state.errorText,
              ),
              isEmpty: selectedValue == null,
              child: Builder(builder: (context) {
                if (selectedValue == null) {
                  return const SizedBox();
                }
                return content;
              }),
            );
          },
        ),
      );
    });
  }
}

class DurationPickerWidget extends StatelessWidget {
  final int initialItem;
  final ValueChanged<int> onSelectedItemChanged;

  const DurationPickerWidget({
    super.key,
    required this.initialItem,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 250.0,
        child: CupertinoPicker(
          itemExtent: 30.0,
          scrollController: FixedExtentScrollController(
            initialItem: initialItem,
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          onSelectedItemChanged: onSelectedItemChanged,
          children: List.generate(
            16,
            (index) {
              return Text(
                  FormatDurationHelper.getFormattedDurationByIndex(index));
            },
          ),
        ),
      ),
    );
  }
}
