import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../utils/utils.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const ConfirmDeleteDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset(AppAssets.appLogo, height: 50.0, width: 120.0),
      content: Text(
        context.loc.want_to_delete,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.loc.no),
        ),
        ElevatedButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context, 1);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
          ),
          child: Text(context.loc.delete),
        ),
      ],
    );
  }
}
