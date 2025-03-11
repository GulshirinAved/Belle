import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class AnimatedToggleWidgetProps<T> {
  final double height;
  final double innerCornerRadius;
  final double cornerRadius;
  final Duration animationDuration;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final ValueChanged<T>? onManuallyChanged;
  final T? selectedValue;

  const AnimatedToggleWidgetProps({
    this.height = 50.0,
    this.innerCornerRadius = AppDimensions.radiusMediumSmall,
    this.cornerRadius = AppDimensions.radiusMediumSmall,
    this.animationDuration = const Duration(milliseconds: 200),
    this.padding = const EdgeInsets.all(AppDimensions.paddingExtraSmall),
    this.onManuallyChanged,
    this.textStyle,
    this.selectedValue,
  });
}
