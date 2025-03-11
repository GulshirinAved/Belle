import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MasterClientInfoScreen extends StatefulWidget {
  final MasterClientDto clientDto;

  const MasterClientInfoScreen({
    super.key,
    required this.clientDto,
  });

  @override
  State<MasterClientInfoScreen> createState() => _MasterClientInfoScreenState();
}

class _MasterClientInfoScreenState extends State<MasterClientInfoScreen> {
  final controller = GetIt.instance<MasterClientInfoController>();

  @override
  void initState() {
    controller.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithStyledLeading(
        title: '',
        isSliver: false,
      ),
      bottomNavigationBar: SafeArea(
        child: StyledBackgroundContainer(
          child: Row(
            spacing: AppDimensions.paddingMedium,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final needUpdate = await context.pushNamed<bool?>(
                      MasterRoutes.editClient,
                      extra: widget.clientDto,
                    );

                    if (needUpdate == null) {
                      return;
                    }
                    if (!context.mounted) {
                      return;
                    }
                    context.pop(true);
                  },
                  child: Text(context.loc.edit),
                ),
              ),
              Expanded(
                child: Observer(builder: (context) {
                  return ElevatedButtonWithState(
                    onPressed: () async {
                      await controller.deleteClient(widget.clientDto);
                      if (!controller.stateManager.isSuccess) {
                        return;
                      }
                      if (!context.mounted) {
                        return;
                      }
                      context.pop(true);
                    },
                    isLoading: controller.stateManager.isLoading,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: Text(context.loc.delete),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              StyledContainer(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Column(
                  spacing: AppDimensions.paddingSmall,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.clientDto.contactName ?? '',
                      style: context.textTheme.appTitle,
                    ),
                    Row(
                      spacing: AppDimensions.paddingSmall,
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 18.0,
                        ),
                        Text('+993 ${widget.clientDto.contactPhone ?? ''}'),
                      ],
                    ),
                  ],
                ),
              ),
              const VSpacer(AppDimensions.paddingMedium),
              // OutlinedButton(
              //   onPressed: () {},
              //   child: Text(context.loc.history),
              // ),
              // const VSpacer(AppDimensions.paddingMedium),
            ],
          ),
        ),
      ),
    );
  }
}
