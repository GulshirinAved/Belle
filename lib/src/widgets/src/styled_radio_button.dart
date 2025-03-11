import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StyledRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onTap;
  final String title;

  const StyledRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue == value;
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unSelectedColor = Theme.of(context).colorScheme.onPrimary;
    final disabledColor = Theme.of(context).colorScheme.secondary;
    final color = isSelected ? selectedColor : unSelectedColor;
    return Material(
      color: Colors.transparent,
      child: RadioListTile<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onTap == null
            ? null
            : (value) {
                if (isSelected) {
                  return;
                }
                onTap?.call(value);
              },
        dense: true,
        visualDensity: VisualDensity.compact,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.only(left: AppDimensions.paddingLarge),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.radiusMedium),
          ),
          side: BorderSide(
            color: onTap != null ? color : disabledColor,
          ),
        ),
        title: Text(title),
      ),
    );
  }
}
