import 'package:flutter/material.dart';

class AnimatedToggleWidgetItem<T> {
  final T value;
  final String title;
  final bool isDisabled;
  final TextStyle? textStyle;

  const AnimatedToggleWidgetItem({
    required this.value,
    required this.title,
    this.isDisabled = false,
    this.textStyle,
  });
}
