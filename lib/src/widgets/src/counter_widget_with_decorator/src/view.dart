import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class CounterWidgetWithDecorator extends StatelessWidget {
  final VoidCallback onRemoveTap;
  final VoidCallback onAddTap;
  final String title;
  final String labelText;

  const CounterWidgetWithDecorator(
      {super.key,
      required this.onRemoveTap,
      required this.onAddTap,
      required this.title,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onRemoveTap,
            icon: const Icon(Icons.remove),
            color: Theme.of(context).colorScheme.primary,
            visualDensity: VisualDensity.compact,
          ),
          Expanded(
              child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 13.0),
          )),
          IconButton(
            onPressed: onAddTap,
            icon: const Icon(Icons.add),
            color: Theme.of(context).colorScheme.primary,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
