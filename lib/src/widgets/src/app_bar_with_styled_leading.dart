import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets.dart';

class AppBarWithStyledLeading extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  // final VoidCallback onBackTap;
  final bool isSliver;
  final PreferredSizeWidget? bottom;

  const AppBarWithStyledLeading({
    super.key,
    required this.title,
    // required this.onBackTap,
    this.isSliver = true, this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverAppBar(
        pinned: true,
        title: Text(title),
        leadingWidth: 80.0,
        bottom: bottom,
        leading: StyledBackButton(
          onTap: () {
            context.pop();
          },
        ),
      );
    }
    return AppBar(
      title: Text(title),
      leadingWidth: 80.0,
      bottom: bottom,
      leading: StyledBackButton(
        onTap: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
