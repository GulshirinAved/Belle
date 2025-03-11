import 'package:belle/src/theme/config/color_scheme_extension.dart';
import 'package:flutter/material.dart';

import 'text_style_extension.dart';

extension ThemeContextExtension on BuildContext {
  ThemeTextStyles get textTheme => Theme.of(this).extension<ThemeTextStyles>()!;
  ColorSchemeColors get colorScheme =>
      Theme.of(this).extension<ColorSchemeColors>()!;
}
