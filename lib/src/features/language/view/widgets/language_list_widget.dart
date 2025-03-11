import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../../../theme/view/config/theme_config.dart';
import '../../controller/language_controller.dart';

class LanguageListWidget extends StatefulWidget {
  /// Using [onPressed] for additional functionality
  ///
  /// For pop navigator etc.
  final VoidCallback onPressed;

  const LanguageListWidget({super.key, required this.onPressed});

  @override
  State<LanguageListWidget> createState() => _LanguageListWidgetState();
}

class _LanguageListWidgetState extends State<LanguageListWidget> {
  final controller = GetIt.instance<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var locale in L10n.supportedLocales)
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingMedium),
            child: Observer(builder: (context) {
              return LanguageButton(
                title: context.loc.locale(locale.languageCode),
                isCurrentLocale: controller.locale == locale,
                onPressed: () {
                  controller.updateLocale(locale);
                  widget.onPressed();
                },
              );
            }),
          ),
      ],
    );
  }
}

class LanguageButton extends StatelessWidget {
  final bool isCurrentLocale;
  final String title;
  final VoidCallback onPressed;

  const LanguageButton(
      {super.key,
      required this.isCurrentLocale,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.buttonWidthDefault,
      height: AppDimensions.buttonHeightDefault,
      child: Builder(
        builder: (context) {
          if (isCurrentLocale) {
            return ElevatedButton(onPressed: onPressed, child: Text(title));
          }
          return OutlinedButton(onPressed: onPressed, child: Text(title));
        },
      ),
    );
  }
}
