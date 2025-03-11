import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class ChooseFileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String? Function(Object?) validator;

  const ChooseFileWidget(
      {super.key, required this.onTap, required this.validator});

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      builder: (state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(1.0),
            errorText: state.hasError ? state.errorText : null,
          ),
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(AppDimensions.radiusLarge),
                      ),
                      border: Border(
                        right: BorderSide(),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ColoredBox(
                        color: Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingExtraLarge,
                            vertical: AppDimensions.paddingMedium,
                          ),
                          child: Center(
                            child: Text(
                              'context.loc.choose_file',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingMedium,
                      ),
                      child: Center(
                        child: Text(
                          'context.loc.no_file_chosen',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
