import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StyledBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const StyledBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
        child: SizedBox(
          height: 40.0,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              visualDensity: VisualDensity.compact,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.radiusMedium),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child:  Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 19.0,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
