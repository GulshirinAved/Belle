import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/make_booking/controller/client_make_booking_controller.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../data/dto/booking_dto.dart';

class ClientMakeBookingScreen extends StatefulWidget {
  final BookingDto? bookingDto;

  const ClientMakeBookingScreen({super.key, this.bookingDto});

  @override
  State<ClientMakeBookingScreen> createState() =>
      _ClientMakeBookingScreenState();
}

class _ClientMakeBookingScreenState extends State<ClientMakeBookingScreen> {
  final controller = GetIt.instance<ClientMakeBookingController>();
  final accountController = GetIt.instance<AccountController>();

  final key = GlobalKey<FormState>();

  @override
  void initState() {
    controller.setContext(context);
    if (accountController.accountInfo != null) {
      final accountInfo = accountController.accountInfo;
      controller.initWithAccountData(
          accountInfo?.phone ?? '', accountInfo?.fullName ?? '');
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithStyledLeading(
        title: '',
        isSliver: false,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLarge,
                        vertical: AppDimensions.paddingLarge,
                      ),
                      child: Text(
                        context.loc.enter_info_to_contact,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    StyledBackgroundContainer(
                      child: Form(
                        key: key,
                        child: Column(
                          children: [
                            StandardInputField(
                              props: StandardInputFieldProps(
                                labelText: context.loc.name_surname,
                                textEditingController:
                                    controller.nameController,
                              ),
                            ),
                            const VSpacer(AppDimensions.paddingMedium),
                            PhoneInputField(
                              props: PhoneInputFieldProps(
                                textEditingController:
                                    controller.phoneController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const VSpacer(AppDimensions.paddingSmall),
                    Observer(builder: (context) {
                      return StyledBackgroundContainer(
                        child: ElevatedButtonWithState(
                          isLoading: controller.stateManager.isLoading,
                          onPressed: () async {
                            if (!(key.currentState?.validate() ?? true)) {
                              return;
                            }
                            final bookingDto = widget.bookingDto!.copyWith(
                              clientPersonFn: controller.nameController.text,
                              clientPhone: controller.phoneController.text,
                            );

                            await controller.makeBooking(bookingDto);
                            if (controller.stateManager.isSuccess) {
                              if (!context.mounted) {
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const BookingSuccessDialog();
                                },
                              );
                            }
                          },
                          child: Text(context.loc.confirm),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookingSuccessDialog extends StatefulWidget {
  const BookingSuccessDialog({super.key});

  @override
  State<BookingSuccessDialog> createState() => _BookingSuccessDialogState();
}

class _BookingSuccessDialogState extends State<BookingSuccessDialog> {
  final authStatusController = GetIt.instance<AuthStatusController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(context.loc.snack_title('success')),
      content: Observer(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_task,
              size: 100.0,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            Text(
              context.loc.request_sent_success,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                  ),
            ),
            if (authStatusController.authLoginStatus ==
                AuthLoginStatus.notLoggedIn) ...[
              Text(
                context.loc.register_to_see_status,
                textAlign: TextAlign.center,
              ),
              const VSpacer(AppDimensions.paddingMedium),
              ElevatedButton(
                onPressed: () {
                  context.goNamed(ClientRoutes.home);
                  context.pushNamed(SharedRoutes.register);
                },
                child: Text(context.loc.register),
              ),
            ],
            if (authStatusController.authLoginStatus ==
                AuthLoginStatus.loggedIn) ...[
              ElevatedButton(
                onPressed: () {
                  context.go(ClientRoutes.home);
                  context.pushNamed(ClientRoutes.notifications);
                },
                child: Text(context.loc.show_request_status),
              ),
            ],
            const VSpacer(AppDimensions.paddingMedium),
            OutlinedButton(
              onPressed: () {
                context.goNamed(ClientRoutes.home);
              },
              child: Text(context.loc.return_to_main),
            ),
          ],
        );
      }),
    );
  }
}
