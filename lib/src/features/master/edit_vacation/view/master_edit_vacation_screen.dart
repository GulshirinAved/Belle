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

class MasterEditVacationScreen extends StatefulWidget {
  final MasterHolidayDto dto;
  const MasterEditVacationScreen({super.key, required this.dto});

  @override
  State<MasterEditVacationScreen> createState() =>
      _MasterEditVacationScreenState();
}

class _MasterEditVacationScreenState extends State<MasterEditVacationScreen> {
  final stateController = GetIt.instance<MasterEditVacationStateController>();
  final controller = GetIt.instance<MasterEditVacationController>();
  final referencesController = GetIt.instance<ReferencesController>();

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
    stateController.initHolidayDto(widget.dto);
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
              return Row(
                spacing: AppDimensions.paddingMedium,
                children: [
                  Expanded(
                    child: ElevatedButtonWithState(
                      isLoading: controller.stateManager.isLoading,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () async {
                        await controller.deleteVacation(widget.dto.id);
                        if (!controller.stateManager.isSuccess) {
                          return;
                        }
                        if (!context.mounted) {
                          return;
                        }
                        context.pop(true);
                      },
                      child: Text(context.loc.delete),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButtonWithState(
                      isLoading: controller.stateManager.isLoading,
                      onPressed: isSelected
                          ? () async {
                              final data =
                                  stateController.generateData(context);
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
                    ),
                  )
                ],
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
