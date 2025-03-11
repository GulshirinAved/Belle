import 'package:flutter/material.dart';

import '../theme.dart';

class ColorSchemeColors extends ThemeExtension<ColorSchemeColors> {
  final Color reviewAvatarColor;

  ColorSchemeColors({
    required this.reviewAvatarColor,
  });

  @override
  ThemeExtension<ColorSchemeColors> copyWith({
    Color? reviewAvatarColor,
  }) {
    return ColorSchemeColors(
      reviewAvatarColor: reviewAvatarColor ?? this.reviewAvatarColor,
    );
  }

  @override
  ThemeExtension<ColorSchemeColors> lerp(
    ThemeExtension<ColorSchemeColors>? other,
    double t,
  ) {
    if (other is! ColorSchemeColors) {
      return this;
    }

    return ColorSchemeColors(
      reviewAvatarColor:
          Color.lerp(reviewAvatarColor, other.reviewAvatarColor, t)!,
    );
  }

  static get light =>
      ColorSchemeColors(reviewAvatarColor: AppColors.lightBlack);

  static get dark => ColorSchemeColors(reviewAvatarColor: AppColors.lightGray);
}
