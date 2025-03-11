import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StyledBackgroundContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const StyledBackgroundContainer(
      {super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingExtraLarge,
            horizontal: AppDimensions.paddingLarge,
          ),
      child: child,
    );
  }
}
