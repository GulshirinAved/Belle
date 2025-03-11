import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/utils.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset(AppAssets.appLogo, height: 50.0, width: 120.0),
      content: Text(
        context.loc.snack_title('success'),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(context.loc.continue_title),
          ),
        ),
      ],
    );
  }
}
