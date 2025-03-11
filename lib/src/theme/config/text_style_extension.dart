import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  final TextStyle appTitle;
  final TextStyle containerTitle;

  // final TextStyle appTitle;
  // final TextStyle appDescription;
  // final TextStyle labelStyle;
  // final TextStyle searchHint;
  // final TextStyle searchInput;
  // final TextStyle settingsDialogLanguage;

  ThemeTextStyles({
    required this.appTitle,
    required this.containerTitle,
    // required this.appDescription,
    // required this.labelStyle,
    // required this.searchHint,
    // required this.searchInput,
    // required this.settingsDialogLanguage,
  });

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? containerTitle,
    TextStyle? appTitle,
    // TextStyle? appDescription,
    // TextStyle? labelStyle,
    // TextStyle? searchHint,
    // TextStyle? searchInput,
  }) {
    return ThemeTextStyles(
      appTitle: appTitle ?? this.appTitle,
      containerTitle: containerTitle ?? this.containerTitle,
      // appDescription: appDescription ?? this.appDescription,
      // labelStyle: labelStyle ?? this.labelStyle,
      // searchHint: searchHint ?? this.searchHint,
      // searchInput: searchInput ?? this.searchInput,
      // settingsDialogLanguage:
      //     settingsDialogLanguage ?? this.settingsDialogLanguage,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return ThemeTextStyles(
      appTitle: TextStyle.lerp(appTitle, other.appTitle, t)!,
      containerTitle: TextStyle.lerp(containerTitle, other.containerTitle, t)!,
    );
  }

  static get light => ThemeTextStyles(
        appTitle: titleMedium.copyWith(
          color: AppColors.lightBlack,
        ),
        containerTitle: titleSmall.copyWith(
          color: AppColors.lightBlack,
        ),
      );

  static get dark => ThemeTextStyles(
        appTitle: titleMedium.copyWith(
          color: AppColors.white,
        ),
        containerTitle: titleSmall.copyWith(
          color: AppColors.white,
        ),
      );
}

const titleMedium = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
);
const titleSmall = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w700,
  fontFamily: AppFonts.onest,
);
