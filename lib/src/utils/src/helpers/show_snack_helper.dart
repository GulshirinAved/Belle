import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:flutter/material.dart';

enum SnackStatus { success, warning, error, message }

class ShowSnackHelper {
  static void showSnack(
      BuildContext context, SnackStatus snackStatus, String? content,
      [VoidCallback? onPressed, Color? backgroundColor, Duration? duration]) {
    Color color = AppColors.green;
    String title = '';
    final theme = Theme.of(context);
    switch (snackStatus) {
      case SnackStatus.success:
        title = 'success';
        break;
      case SnackStatus.warning:
        color = Colors.orangeAccent;
        title = 'warning';
        break;
      case SnackStatus.error:
        color = theme.colorScheme.error;
        title = 'error';
        break;
      case SnackStatus.message:
        color = theme.colorScheme.primary;
        title = 'message';
        break;
    }
    if (backgroundColor != null) {
      color = backgroundColor;
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(milliseconds: 4000),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.loc.snack_title(title),
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            Text(
              content == null || content.isEmpty
                  ? context.loc.snack_title(title)
                  : content,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
        action: onPressed != null
            ? SnackBarAction(
                label: context.loc.show,
                onPressed: onPressed,
                backgroundColor: Theme.of(context).colorScheme.primary,
                textColor: AppColors.white,
              )
            : null,
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
