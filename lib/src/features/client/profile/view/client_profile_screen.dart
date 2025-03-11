import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  final _roleController = GetIt.instance<RoleController>();
  final _authStatusController = GetIt.instance<AuthStatusController>();
  final _accountController = GetIt.instance<AccountController>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(builder: (context) {
          if (!_accountController.isSuccess) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                  isLoading: _accountController.isLoading,
                  isError: _accountController.isError,
                  onError: () {
                    _accountController.getAccount();
                  }),
            );
          }
          return SliverAppBar(
            title: Text(context.loc.profile),
            pinned: true,
            bottom: _roleController.isMaster
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(70.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge,
                          vertical: AppDimensions.paddingMedium),
                      child: AnimatedToggleWidget<UserType?>(
                        initialValue: UserType.client,
                        onChanged: (value) {
                          if (value != UserType.master) {
                            return;
                          }
                          context.go(MasterRoutes.profile);
                        },
                        props: const AnimatedToggleWidgetProps(
                          selectedValue: UserType.client,
                        ),
                        items: [
                          AnimatedToggleWidgetItem(
                            value: UserType.client,
                            title: context.loc.client,
                          ),
                          AnimatedToggleWidgetItem(
                            value: UserType.master,
                            title: context.loc.master,
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          );
        }),
        Observer(builder: (context) {
          if (_authStatusController.authLoginStatus !=
              AuthLoginStatus.loggedIn) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: _authStatusController.authLoginStatus ==
                    AuthLoginStatus.loading,
                isError: _authStatusController.authLoginStatus ==
                    AuthLoginStatus.error,
                onError: () {
                  _accountController.getAccount();
                },
                isSliver: true,
              ),
            );
          }
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                  ),
                  child: Text(
                    'Hi Belle',
                    style: context.textTheme.appTitle,
                  ),
                ),
                const VSpacer(AppDimensions.paddingMedium),
                // StyledBackgroundContainer(child: child),
                StyledBackgroundContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StyledContainerWithColumn(
                        items: [
                          ProfileItemWidget(
                            onTap: () {
                              context.pushNamed(ClientRoutes.personalInfo);
                            },
                            title: context.loc.personal_info,
                          ),
                          ProfileItemWidget(
                            onTap: () {
                              context.pushNamed(
                                ClientRoutes.myBookings,
                              );
                            },
                            title: context.loc.my_bookings,
                          ),
                          ProfileItemWidget(
                            onTap: () {},
                            title: context.loc.contact_us,
                          ),
                          ProfileItemWidget(
                            onTap: () {
                              context.pushNamed(SharedRoutes.privacyPolicy);
                            },
                            title: context.loc.privacy,
                          ),
                          ProfileItemWidget(
                            onTap: () {},
                            title: context.loc.delete_account,
                            textColor: Theme.of(context).colorScheme.error,
                            iconColor: Theme.of(context).colorScheme.error,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDimensions.paddingMedium,
                              horizontal: AppDimensions.paddingMedium,
                            ),
                            child: FutureBuilder<PackageInfo>(
                                future: _getPackageInfo(),
                                builder: (context, snapshot) {
                                  return Text(
                                    '${context.loc.app_version} ${snapshot.data?.version}',
                                  );
                                }),
                          ),
                        ],
                      ),
                      const VSpacer(AppDimensions.paddingExtraLarge),
                      OutlinedButton(
                        onPressed: () {
                          _accountController.logout(() {
                            context.goNamed(ClientRoutes.home);
                            context.pushNamed(SharedRoutes.register);
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.error),
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: Observer(builder: (context) {
                          if (_accountController.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          return Text(context.loc.logout);
                        }),
                      ),
                    ],
                  ),
                ),
                const VSpacer(AppDimensions.paddingMedium),
              ],
            ),
          );
        }),
      ],
    );
  }

  Future<PackageInfo> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}

class ProfileItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? textColor;
  final Color? iconColor;

  const ProfileItemWidget(
      {super.key,
      this.onTap,
      required this.title,
      this.textColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap != null ? 1.0 : 0.4,
      child: GestureDetector(
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
      ),
    );
  }
}

class TitleWithIconRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? textColor;
  final Color? iconColor;
  final double? iconSize;

  const TitleWithIconRow({
    super.key,
    required this.title,
    required this.icon,
    this.textColor,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: textColor,
                ),
          ),
        ),
        Icon(icon, color: iconColor, size: iconSize ?? 16.0),
      ],
    );
  }
}

enum UserType {
  client,
  master,
}
