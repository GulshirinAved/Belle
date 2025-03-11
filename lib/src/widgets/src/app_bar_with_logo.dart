import 'package:belle/src/theme/view/config/theme_config.dart';
import 'package:flutter/material.dart';

import 'package:belle/src/utils/utils.dart';

class AppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  final bool isSliver;
  const AppBarWithLogo({super.key, required this.isSliver});

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverAppBar(
        title: Image.asset(AppAssets.appLogo, height: 50.0, width: 120.0),
        centerTitle: true,
        toolbarHeight: kToolbarHeight + AppDimensions.paddingLarge,
        pinned: true,
      );
    }
    return AppBar(
      title: Image.asset(AppAssets.appLogo, height: 50.0, width: 120.0),
      toolbarHeight: kToolbarHeight + AppDimensions.paddingLarge,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
