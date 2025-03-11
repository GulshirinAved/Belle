import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/theme.dart';
import '../widgets.dart';

class AgreementCheckboxWithValidator extends StatelessWidget {
  final bool agree;
  final VoidCallback onChanged;
  const AgreementCheckboxWithValidator(
      {super.key, required this.agree, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (_) {
        if (!agree) {
          return context.loc.required;
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  isError: state.hasError,
                  value: agree,
                  onChanged: (_) => onChanged(),
                  visualDensity: VisualDensity.compact,
                ),
                const HSpacer(AppDimensions.paddingSmall),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(SharedRoutes.privacyPolicy);
                    },
                    child: Text(
                      context.loc.agree_with_policy,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                )
              ],
            ),
            if (state.hasError) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                  vertical: AppDimensions.paddingSmall,
                ),
                child: Text(
                  state.errorText ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              )
            ],
          ],
        );
      },
    );
  }
}
