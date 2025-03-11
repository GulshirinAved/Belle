import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:belle/src/widgets/src/app_bar_with_styled_leading.dart';
import 'package:belle/src/widgets/src/elevated_button_with_state.dart';
import 'package:belle/src/widgets/src/input_fields/input_fields.dart';
import 'package:belle/src/widgets/src/spacers/spacers.dart';
import 'package:belle/src/widgets/src/state_control_widget.dart';
import 'package:belle/src/widgets/src/styled_background_container.dart';
import 'package:belle/src/widgets/src/styled_checkbox.dart';
import 'package:belle/src/widgets/src/styled_radio_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/src/choose_image_widget/choose_image_widget.dart';
import '../../master.dart';

class MasterPersonalInfoScreen extends StatefulWidget {
  const MasterPersonalInfoScreen({super.key});

  @override
  State<MasterPersonalInfoScreen> createState() =>
      _MasterPersonalInfoScreenState();
}

class _MasterPersonalInfoScreenState extends State<MasterPersonalInfoScreen> {
  final stateController = GetIt.instance<MasterPersonalInfoStateController>();
  final controller = GetIt.instance<MasterPersonalInfoController>();
  final avatarController =
      GetIt.instance<MasterPersonalInfoAvatarUpdateController>();
  final accountController = GetIt.instance<AccountController>();
  final referencesController = GetIt.instance<ReferencesController>();
  final referencesForRegionsController =
      GetIt.instance<ReferencesForRegionsController>();

  @override
  void initState() {
    controller.setContext(context);
    avatarController.setContext(context);
    stateController.setContext(context);
    referencesForRegionsController.setContext(context);
    stateController.initAccount(accountController.accountInfo);
    super.initState();
  }

  Future<T?> _showSelectBottomSheet<T>(
      BuildContext context,
      String title,
      List<T>? items,
      T? groupValue,
      String Function(T) titleBuilder,
      bool isLoading,
      final void Function(T?) onTap) async {
    return await showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) {
        return _SelectLocationBottomSheet<T>(
          title: title,
          items: items,
          groupValue: groupValue,
          titleBuilder: titleBuilder,
          onTap: onTap,
        );
      },
    );
  }

  void _showLoadingBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const LoadingBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.personal_info,
        isSliver: false,
      ),
      bottomNavigationBar: StyledBackgroundContainer(
        child: Observer(builder: (context) {
          return ElevatedButtonWithState(
            isLoading: controller.stateManager.isLoading,
            onPressed: () async {
              if (stateController.isNotChanged()) {
                return;
              }
              await controller
                  .updateAccountData(stateController.generateData());
              if (!controller.stateManager.isSuccess) {
                return;
              }
              if (!context.mounted) {
                return;
              }
              Navigator.pop(context);
            },
            child: Text(context.loc.save),
          );
        }),
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!accountController.isSuccess) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: accountController.isLoading,
                isError: accountController.isError,
                onError: () {
                  accountController.getAccount();
                },
              ),
            );
          }
          return ListView(
            children: [
              MasterPersonalInfoComponent(
                title: context.loc.personal_info,
                children: [
                  Row(
                    spacing: AppDimensions.paddingLarge,
                    children: [
                      MasterAvatarPickerWidget(
                        child: Observer(builder: (context) {
                          if (avatarController.stateManager.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ChooseAndChosenFileWidget(
                            height:
                                AppDimensions.avatarPictureHeight.toDouble(),
                            width: AppDimensions.avatarPictureWidth.toDouble(),
                            onDeleteTap: () async {
                              await avatarController.deleteAccountAvatar();
                              if (!avatarController.stateManager.isSuccess) {
                                return;
                              }
                              stateController.deletePicture();
                            },
                            onPickTap: () async {
                              final tempImage =
                                  await stateController.pickTempPicture();
                              if (tempImage == null) {
                                return;
                              }

                              await avatarController
                                  .updateAccountAvatar(tempImage);
                              if (!avatarController.stateManager.isSuccess) {
                                return;
                              }
                              stateController.saveTempImage();
                            },
                            image: stateController.picture,
                            imagePath: stateController.picturePath,
                            emptyWidget:
                                const MasterAvatarPickerEmptyComponent(),
                          );
                        }),
                      ),
                      Expanded(
                        child: Column(
                          spacing: AppDimensions.paddingMedium,
                          children: [
                            StandardInputField(
                              props: StandardInputFieldProps(
                                labelText: context.loc.first_name,
                                textEditingController:
                                    stateController.firstNameController,
                              ),
                            ),
                            StandardInputField(
                              props: StandardInputFieldProps(
                                labelText: context.loc.last_name,
                                textEditingController:
                                    stateController.lastNameController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  StandardInputField(
                    props: StandardInputFieldProps(
                      labelText: context.loc.email,
                      textEditingController: stateController.emailController,
                    ),
                  ),
                  PhoneInputField(
                    props: PhoneInputFieldProps(
                      textEditingController: stateController.phoneController,
                      enabled: false,
                    ),
                  ),
                  StandardInputField(
                    props: StandardInputFieldProps(
                      labelText: context.loc.about_me,
                      textEditingController: stateController.aboutMeController,
                    ),
                  ),
                ],
              ),
              const VSpacer(AppDimensions.paddingMedium),
              MasterPersonalInfoComponent(
                title: context.loc.address,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (!context.mounted) {
                        return;
                      }
                      final city = await _showSelectBottomSheet<CityDto>(
                        context,
                        context.loc.select_city,
                        referencesController.data?.cities,
                        stateController.selectedCity,
                        (city) => city.name ?? '',
                        referencesForRegionsController.stateManager.isLoading,
                        (value) async {
                          _showLoadingBottomSheet();
                          await referencesForRegionsController
                              .fetchReferences(value?.id);
                          if (!referencesForRegionsController
                              .stateManager.isSuccess) {
                            return;
                          }
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.pop(context);

                          Navigator.pop(context, value);
                        },
                      );
                      if (city == null) {
                        return;
                      }
                      if (!context.mounted) {
                        return;
                      }
                      final region = await _showSelectBottomSheet<RegionDto>(
                        context,
                        context.loc.select_region,
                        referencesForRegionsController.data?.regions,
                        stateController.selectedRegion,
                        (region) => region.name ?? '',
                        false,
                        (value) {
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.pop(context, value);
                        },
                      );
                      if (region == null) {
                        return;
                      }
                      stateController.updateCity(city);
                      stateController.updateRegion(region);
                    },
                    child: Observer(builder: (context) {
                      final title = stateController.selectedCity == null
                          ? ''
                          : '${stateController.selectedCity?.name ?? ''}, ${stateController.selectedRegion?.name ?? ''}';
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: context.loc.work_location,
                        ),
                        isEmpty: stateController.selectedCity == null,
                        child: Text(title),
                      );
                    }),
                  ),
                  StandardInputField(
                    props: StandardInputFieldProps(
                      labelText: context.loc.address,
                      textEditingController: stateController.addressController,
                    ),
                  ),
                ],
              ),
              const VSpacer(AppDimensions.paddingMedium),
              MasterPersonalInfoComponent(
                title: context.loc.your_gender,
                children: [
                  Text('(${context.loc.you_can_change_once_per_month})'),
                  Observer(builder: (context) {
                    return Row(
                      children: [
                        Expanded(
                          child: StyledRadioButton<int>(
                            value: 1,
                            groupValue: stateController.gender,
                            onTap: (value) =>
                                stateController.toggleGender(value ?? 1),
                            title: context.loc.man,
                          ),
                        ),
                        const HSpacer(AppDimensions.paddingMedium),
                        Expanded(
                          child: StyledRadioButton<int>(
                            value: 2,
                            groupValue: stateController.gender,
                            onTap: (value) =>
                                stateController.toggleGender(value ?? 2),
                            title: context.loc.woman,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const VSpacer(AppDimensions.paddingMedium),
              MasterPersonalInfoComponent(
                title: context.loc.know_languages,
                children: [
                  Text('(${context.loc.this_will_affects_client_search})'),
                  Observer(builder: (context) {
                    return Row(
                      children: [
                        Expanded(
                          child: StyledCheckbox(
                            value:
                                stateController.selectedLanguages.contains(1),
                            onChanged: (_) => stateController.toggleLanguage(1),
                            title: 'Turkmen',
                          ),
                        ),
                        const HSpacer(AppDimensions.paddingMedium),
                        Expanded(
                          child: StyledCheckbox(
                            value:
                                stateController.selectedLanguages.contains(2),
                            onChanged: (_) => stateController.toggleLanguage(2),
                            title: 'Русский',
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const VSpacer(AppDimensions.paddingMedium),
              MasterPersonalInfoComponent(
                title: context.loc.service_location,
                children: [
                  Observer(builder: (context) {
                    return Row(
                      children: [
                        Expanded(
                          child: StyledCheckbox(
                            value: stateController.selectedServiceLocations
                                .contains(1),
                            onChanged: (_) =>
                                stateController.toggleServiceLocations(1),
                            title: context.loc.service_locations('in_salon'),
                          ),
                        ),
                        const HSpacer(AppDimensions.paddingMedium),
                        Expanded(
                          child: StyledCheckbox(
                            value: stateController.selectedServiceLocations
                                .contains(2),
                            onChanged: (_) =>
                                stateController.toggleServiceLocations(2),
                            title: context.loc.service_locations('away'),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const VSpacer(AppDimensions.paddingMedium),
            ],
          );
        }),
      ),
    );
  }
}

class MasterAvatarPickerWidget extends StatelessWidget {
  final Widget child;

  const MasterAvatarPickerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: 120.0,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(
          AppDimensions.radiusLarge,
        ),
        dashPattern: const [9],
        color: Theme.of(context).colorScheme.onSurface,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.belleGray,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppDimensions.radiusLarge,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: child,
          ),
        ),
      ),
    );
  }
}

class MasterAvatarPickerEmptyComponent extends StatelessWidget {
  const MasterAvatarPickerEmptyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.darkPink,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppDimensions.radiusLarge,
          ),
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      child: Center(
        child: Text(context.loc.pick_avatar),
      ),
    );
  }
}

class MasterPersonalInfoComponent extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const MasterPersonalInfoComponent({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return StyledBackgroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppDimensions.paddingLarge,
        children: [
          Text(
            title,
            style: context.textTheme.appTitle,
          ),
          ...children,
        ],
      ),
    );
  }
}

class BottomSheetHeader extends StatelessWidget {
  final String title;

  const BottomSheetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const VSpacer(AppDimensions.paddingLarge),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimensions.radiusLarge),
              ),
            ),
            height: 5.0,
            width: 30.0,
          ),
        ),
        const VSpacer(AppDimensions.paddingLarge),
        Text(
          title,
          style: context.textTheme.appTitle,
          textAlign: TextAlign.center,
        ),
        const VSpacer(AppDimensions.paddingLarge),
        const Divider(height: 0.0),
      ],
    );
  }
}

class BottomSheetList<T> extends StatelessWidget {
  final List<T>? items;
  final T? groupValue;
  final String Function(T) titleBuilder;
  final void Function(T?) onTap;

  const BottomSheetList({
    super.key,
    required this.items,
    required this.groupValue,
    required this.titleBuilder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingLarge,
      ),
      separatorBuilder: (_, __) {
        return const VSpacer(AppDimensions.paddingMedium);
      },
      itemCount: items?.length ?? 0,
      itemBuilder: (context, index) {
        final item = items?[index];
        return StyledRadioButton<T?>(
          value: item,
          groupValue: groupValue,
          onTap: onTap,
          title: item != null ? titleBuilder(item) : '',
        );
      },
    );
  }
}

class _SelectLocationBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<T>? items;
  final T? groupValue;
  final String Function(T) titleBuilder;
  final void Function(T?) onTap;

  // final bool isLoading;

  const _SelectLocationBottomSheet({
    required this.title,
    required this.items,
    required this.groupValue,
    required this.titleBuilder,
    required this.onTap,
    // required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          BottomSheetHeader(title: title),
          BottomSheetList<T>(
            items: items,
            groupValue: groupValue,
            titleBuilder: titleBuilder,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class LoadingBottomSheet extends StatelessWidget {
  const LoadingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.3,
        width: MediaQuery.sizeOf(context).width,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
