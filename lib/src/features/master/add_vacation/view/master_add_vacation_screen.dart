import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/widgets/src/app_bar_with_styled_leading.dart';
import 'package:belle/src/widgets/src/elevated_button_with_state.dart';
import 'package:belle/src/widgets/src/spacers/spacers.dart';
import 'package:belle/src/widgets/src/styled_background_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/shared.dart';
import '../../master.dart';

class MasterAddVacationScreen extends StatefulWidget {
  const MasterAddVacationScreen({super.key});

  @override
  State<MasterAddVacationScreen> createState() =>
      _MasterAddVacationScreenState();
}

class _MasterAddVacationScreenState extends State<MasterAddVacationScreen> {
  final stateController = GetIt.instance<MasterAddVacationStateController>();
  final controller = GetIt.instance<MasterAddVacationController>();
  final referencesController = GetIt.instance<ReferencesController>();

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.vacation,
        isSliver: false,
      ),
      bottomNavigationBar: SafeArea(
        child: StyledBackgroundContainer(
          child: Observer(
            builder: (context) {
              final isSelected = stateController.selectedReason != null;
              return ElevatedButtonWithState(
                isLoading: controller.stateManager.isLoading,
                onPressed: isSelected
                    ? () async {
                        final data = stateController.generateData(context);
                        await controller.sendData(data);
                        if (!controller.stateManager.isSuccess) {
                          return;
                        }
                        if (!context.mounted) {
                          return;
                        }
                        context.pop(true);
                      }
                    : null,
                child: Text(context.loc.save),
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            StyledBackgroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScheduleDateRangeCalendar(
                    focusedDay: DateTime.now(),
                    rangeStartDay: stateController.rangeStartDate,
                    rangeEndDay: stateController.rangeEndDate,
                    onRangeSelected: (start, end) {
                      stateController.changeRangeDates(start, end);
                    },
                  ),
                  Observer(builder: (context) {
                    final isSelected = stateController.selectedReason != null;
                    final icon = isSelected ? const Icon(Icons.edit) : null;
                    final title = isSelected
                        ? '${context.loc.reason}: ${(stateController.selectedReason?.name ?? '')}'
                        : context.loc.choose_reason;
                    return OutlinedButton.icon(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Observer(builder: (context) {
                              return ReasonPicker(
                                onChanged: (value) {
                                  stateController.changeSelectedReason(value);
                                  Navigator.pop(context);
                                },
                                selectedItem: stateController.selectedReason,
                                items: referencesController.data?.holidays,
                              );
                            });
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white,
                      ),
                      icon: icon,
                      iconAlignment: IconAlignment.end,
                      label: Text(title),
                    );
                  }),
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

class ReasonPicker extends StatelessWidget {
  final ValueChanged<HolidayDto?> onChanged;
  final List<HolidayDto>? items;
  final HolidayDto? selectedItem;

  const ReasonPicker({
    super.key,
    required this.onChanged,
    required this.items,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingLarge,
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimensions.radiusLarge,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: items?.map((item) {
                      return Column(
                        children: [
                          RadioListTile(
                            value: item,
                            groupValue: selectedItem,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(item.name ?? ''),
                            onChanged: onChanged,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: item == items?.first
                                    ? const Radius.circular(
                                        AppDimensions.radiusLarge)
                                    : Radius.zero,
                                bottom: item == items?.last
                                    ? const Radius.circular(
                                        AppDimensions.radiusLarge)
                                    : Radius.zero,
                              ),
                            ),
                          ),
                          if (item != items?.last) const Divider(height: 0.0),
                        ],
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
            ),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppColors.white,
                ),
                foregroundColor: AppColors.white,
              ),
              child: Text(context.loc.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
