import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../theme/theme.dart';
import '../../../../../../../widgets/widgets.dart';
import '../../../../../../client/client.dart';
import '../../../../../shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginClientController = GetIt.instance<LoginClientController>();
  final loginMasterController = GetIt.instance<LoginMasterController>();

  final pageController = PageController();

  UserType userType = UserType.client;

  @override
  void initState() {
    loginClientController.setContext(context);
    loginMasterController.setContext(context);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    loginClientController.disposeContext();
    loginMasterController.disposeContext();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarWithStyledLeading(
        title: '',
        isSliver: false,
      ),
      body: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.height / 3,
          //   ),
          // ),
          SliverFillRemaining(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    context.loc.login,
                    style: context.textTheme.appTitle,
                  ),
                  const VSpacer(AppDimensions.paddingLarge),
                  SizedBox(
                    height: 70.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLarge,
                        vertical: AppDimensions.paddingMedium,
                      ),
                      child: AnimatedToggleWidget<UserType>(
                        initialValue: UserType.client,
                        onChanged: (value) {
                          if (loginClientController.isLoading ||
                              loginMasterController.isLoading) {
                            return;
                          }
                          if (value == UserType.client) {
                            pageController.jumpToPage(0);
                          } else {
                            pageController.jumpToPage(1);
                          }
                          userType = value;
                          setState(() {});
                        },
                        props: AnimatedToggleWidgetProps<UserType>(
                          selectedValue: userType,
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
                  ),
                  Flexible(
                    // constraints: BoxConstraints(
                    //   maxHeight: MediaQuery.of(context).size.height / 3,
                    // ),
                    child: Observer(builder: (context) {
                      return PageView(
                        controller: pageController,
                        physics: loginClientController.isLoading ||
                                loginMasterController.isLoading
                            ? const NeverScrollableScrollPhysics()
                            : null,
                        onPageChanged: (value) {
                          if (userType == UserType.client) {
                            userType = UserType.master;
                          } else {
                            userType = UserType.client;
                          }
                          setState(() {});
                        },
                        children: [
                          LoginClientWidget(controller: loginClientController),
                          LoginMasterWidget(controller: loginMasterController),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
