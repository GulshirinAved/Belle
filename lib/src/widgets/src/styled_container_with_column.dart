import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StyledContainerWithColumn extends StatelessWidget {
  final List<Widget> items;

  const StyledContainerWithColumn({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusMedium),
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items,
      ),
    );
  }
}

class DualToneContainer extends StatelessWidget {
  final int index;
  final Widget child;
  final int length;
  final EdgeInsetsGeometry? padding;
  final Border? border;

  const DualToneContainer({
    super.key,
    required this.index,
    required this.length,
    required this.child,
    this.padding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = _getBorderRadius(index, length);
    final border = index < length - 1
        ? Border(
            bottom: BorderSide(color: Theme.of(context).colorScheme.secondary),
          )
        : this.border;
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingSmall,
            horizontal: AppDimensions.paddingMedium,
          ),
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? Theme.of(context).colorScheme.surfaceContainer
            : Theme.of(context).colorScheme.secondary,
        borderRadius: borderRadius,
        border: border,
      ),
      child: child,
    );
  }

  BorderRadiusGeometry? _getBorderRadius(int index, int length) {
    if (length == 1) {
      return const BorderRadius.vertical(
        top: Radius.circular(AppDimensions.radiusMedium),
        bottom: Radius.circular(AppDimensions.radiusMedium),
      );
    } else if (index == 0) {
      return const BorderRadius.vertical(
        top: Radius.circular(AppDimensions.radiusMedium),
      );
    } else if (index == length - 1) {
      return const BorderRadius.vertical(
        bottom: Radius.circular(AppDimensions.radiusMedium),
      );
    }
    return null;
  }
}

class StyledContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const StyledContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusMedium),
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      clipBehavior: Clip.antiAlias,
      padding: padding,
      child: child,
    );
  }
}
