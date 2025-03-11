import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:belle/src/widgets/src/app_bar_with_styled_leading.dart';
import 'package:belle/src/widgets/src/elevated_button_with_state.dart';
import 'package:belle/src/widgets/src/input_fields/input_fields.dart';
import 'package:belle/src/widgets/src/styled_background_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../master.dart';

class MasterEditClientScreen extends StatefulWidget {
  final MasterClientDto clientDto;

  const MasterEditClientScreen({
    super.key,
    required this.clientDto,
  });

  @override
  State<MasterEditClientScreen> createState() => _MasterEditClientScreenState();
}

class _MasterEditClientScreenState extends State<MasterEditClientScreen> {
  final formKey = GlobalKey<FormState>();
  final controller = GetIt.instance<MasterEditClientController>();
  final stateController = GetIt.instance<MasterEditClientStateController>();

  @override
  void initState() {
    stateController.setData(widget.clientDto);
    controller.setContext(context);
    stateController.setContext(context);
    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();
    controller.disposeContext();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.edit,
        isSliver: false,
      ),
      body: SafeArea(
        child: Column(
          spacing: AppDimensions.paddingMedium,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            StyledBackgroundContainer(
              child: Form(
                key: formKey,
                child: Column(
                  spacing: AppDimensions.paddingMedium,
                  children: [
                    StandardInputField(
                      props: StandardInputFieldProps(
                        textEditingController: stateController.nameController,
                        labelText: context.loc.name_surname,
                        validator: ValidationBuilder(
                          localeName: context.loc.localeName,
                        ).required().build(),
                      ),
                    ),
                    PhoneInputField(
                      props: PhoneInputFieldProps(
                        textEditingController: stateController.phoneController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StyledBackgroundContainer(
              child: Observer(builder: (context) {
                return ElevatedButtonWithState(
                  isLoading: controller.stateManager.isLoading,
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    await controller.editClient(
                        data: stateController.generateData());
                    if (!controller.stateManager.isSuccess) {
                      return;
                    }
                    if (!context.mounted) {
                      return;
                    }
                    context.pop(true);
                  },
                  child: Text(context.loc.save),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
