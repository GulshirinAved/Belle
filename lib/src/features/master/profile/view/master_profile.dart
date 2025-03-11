import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/core.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../../client/client.dart';
import '../../../shared/shared.dart';

class MasterProfileScreen extends StatefulWidget {
  const MasterProfileScreen({super.key});

  @override
  State<MasterProfileScreen> createState() => _MasterProfileScreenState();
}

class _MasterProfileScreenState extends State<MasterProfileScreen> {
  final _accountController = GetIt.instance<AccountController>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(context.loc.profile),
          pinned: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium),
              child: AnimatedToggleWidget<UserType?>(
                initialValue: UserType.master,
                onChanged: (value) {
                  if (value != UserType.client) {
                    return;
                  }
                  context.go(ClientRoutes.home);
                },
                props: const AnimatedToggleWidgetProps(
                  selectedValue: UserType.master,
                ),
                items: [
                  AnimatedToggleWidgetItem(
                      value: UserType.client, title: context.loc.client),
                  AnimatedToggleWidgetItem(
                      value: UserType.master, title: context.loc.master),
                ],
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            spacing: AppDimensions.paddingMedium,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StyledBackgroundContainer(
                child: StyledContainerWithColumn(
                  items: [
                    ProfileItemWidget(
                      onTap: () async {
                        await context.pushNamed(MasterRoutes.personalInfo);
                        _accountController.getAccount();
                      },
                      title: context.loc.personal_info,
                    ),
                    ProfileItemWidget(
                      onTap: () {
                        context.pushNamed(MasterRoutes.myServices);
                      },
                      title: context.loc.add_services,
                    ),
                    ProfileItemWidget(
                      onTap: () {
                        context.pushNamed(MasterRoutes.portfolio);
                      },
                      title: context.loc.portfolio,
                    ),
                    ProfileItemWidget(
                      onTap: () {
                        context.pushNamed(MasterRoutes.workShifts);
                      },
                      title: context.loc.working_hours,
                    ),
                    ProfileItemWidget(
                      // onTap: () {},
                      title: context.loc.reviews,
                    ),
                    ProfileItemWidget(
                      // onTap: () {},
                      title: context.loc.contact_us,
                    ),
                    ProfileItemWidget(
                      onTap: () {
                        context.pushNamed(SharedRoutes.privacyPolicy);
                      },
                      // enabled: true,
                      title: context.loc.privacy,
                    ),
                    ProfileItemWidget(
                      // onTap: () {},
                      title: context.loc.delete_account,
                      textColor: Theme.of(context).colorScheme.error,
                      iconColor: Theme.of(context).colorScheme.error,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium,
                        vertical: AppDimensions.paddingMedium,
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
              ),
              StyledBackgroundContainer(
                child: OutlinedButton(
                  onPressed: () {
                    _accountController.logout(() {
                      context.goNamed(ClientRoutes.home);
                      context.pushNamed(SharedRoutes.register);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side:
                        BorderSide(color: Theme.of(context).colorScheme.error),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<PackageInfo> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
