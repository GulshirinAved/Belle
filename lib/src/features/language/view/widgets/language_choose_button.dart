import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import 'language_list_widget.dart';

class LanguageChooseButton extends StatelessWidget {
  const LanguageChooseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.loc.choose_language,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: AppFonts.onest,
                          fontSize: 16.0,
                        ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              content: LanguageListWidget(
                onPressed: () {},
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.language_rounded),
    );
  }
}
