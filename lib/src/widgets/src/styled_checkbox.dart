import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StyledCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?) onChanged;
  final String title;
  const StyledCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value;
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unSelectedColor = Theme.of(context).colorScheme.onPrimary;
    final color = isSelected ? selectedColor : unSelectedColor;
    return Material(
      color: Colors.transparent,
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        dense: true,
        visualDensity: VisualDensity.compact,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.only(left: AppDimensions.paddingLarge),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.radiusMedium),
          ),
          side: BorderSide(
            color: color,
          ),
        ),
        title: Text(title),
      ),
    );
  }
}
