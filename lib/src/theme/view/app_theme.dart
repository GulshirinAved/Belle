import 'package:belle/src/theme/config/color_scheme_extension.dart';
import 'package:belle/src/theme/config/text_style_extension.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'config/theme_config.dart';

class ColorGenerator {
  static MainColorConfig generateColors(Color baseColor) {
    final primaryColor = baseColor;
    final primaryLightColor = _lightenColor(baseColor, 0.63);
    final primaryDarkColor = _darkenColorTo(baseColor, 0.07);
    final secondaryDarkColor = _darkenColorTo(baseColor, 0.10);

    return MainColorConfig(
      primaryColor: primaryColor,
      primaryLightColor: primaryLightColor,
      primaryDarkColor: primaryDarkColor,
      secondaryDarkColor: secondaryDarkColor,
    );
  }

  static Color _lightenColor(Color color, double factor) {
    final hsl = HSLColor.fromColor(color);
    final lightenedHsl =
        hsl.withLightness((hsl.lightness + factor).clamp(0.0, 1.0));
    return lightenedHsl.toColor();
  }

  static Color _darkenColorTo(Color color, double targetLightness) {
    final hsl = HSLColor.fromColor(color);
    final darkenedHsl = hsl.withLightness(targetLightness);
    return darkenedHsl.toColor();
  }
}

class MainColorConfig {
  final Color primaryColor;
  final Color primaryLightColor;
  final Color primaryDarkColor;
  final Color secondaryDarkColor;

  const MainColorConfig({
    required this.primaryColor,
    required this.primaryLightColor,
    required this.primaryDarkColor,
    required this.secondaryDarkColor,
  });

  factory MainColorConfig.standard() {
    return const MainColorConfig(
      primaryColor: AppColors.darkPink,
      primaryDarkColor: AppColors.darkPinkDark,
      primaryLightColor: AppColors.gray,
      secondaryDarkColor: AppColors.belleGray,
    );
  }
}

class AppTheme {
  const AppTheme._();

  static ThemeData darkTheme([MainColorConfig? config]) {
    final mainColorConfig = config ?? MainColorConfig.standard();
    final colorSchemeConfig = ColorSchemeConfig.darkScheme(mainColorConfig);
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: AppFonts.onest,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          fontFamily: AppFonts.onest,
        ),
      ),
      elevatedButtonTheme: AppThemeConfigs.getElevatedButtonTheme(
        backgroundColor: mainColorConfig.primaryColor,
      ),
      dividerTheme: DividerThemeData(
        color: colorSchemeConfig.secondary,
      ),
      outlinedButtonTheme: AppThemeConfigs.getOutlinedButtonTheme(
        sideColor: mainColorConfig.primaryColor,
        foregroundColor: mainColorConfig.primaryColor,
        backgroundColor: mainColorConfig.primaryDarkColor,
      ),
      bottomNavigationBarTheme: AppThemeConfigs.getBottomNavTheme(
        selectedItemColor: mainColorConfig.primaryColor,
      ),
      navigationBarTheme: AppThemeConfigs.getNavBarTheme(
        selectedIconColor: mainColorConfig.primaryColor,
        selectedLabelColor: mainColorConfig.primaryColor,
        indicatorColor: mainColorConfig.secondaryDarkColor,
        shadowColor: mainColorConfig.secondaryDarkColor,
        overlayColor: mainColorConfig.secondaryDarkColor,
        backgroundColor: mainColorConfig.primaryDarkColor,
      ),
      checkboxTheme: AppThemeConfigs.getCheckboxTheme(
        selectedItemColor: mainColorConfig.primaryColor,
        unselectedItemColor: mainColorConfig.primaryDarkColor,
      ),
      floatingActionButtonTheme:
          AppThemeConfigs.getFloatingActionButtonThemeData(
        foregroundColor: colorSchemeConfig.onPrimary,
        backgroundColor: colorSchemeConfig.primary,
      ),
      inputDecorationTheme: AppThemeConfigs.getInputDecorationTheme(),
      chipTheme: AppThemeConfigs.getChipTheme(
        backgroundColor: mainColorConfig.primaryColor,
        sideColor: mainColorConfig.primaryColor,
      ),
      colorScheme: colorSchemeConfig,
      extensions: [
        ThemeTextStyles.dark,
        ColorSchemeColors.dark,
      ],
    );
  }

  static ThemeData lightTheme([MainColorConfig? config]) {
    final mainColorConfig = MainColorConfig.standard();
    final colorSchemeConfig = ColorSchemeConfig.lightScheme(mainColorConfig);

    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: AppFonts.onest,
      scaffoldBackgroundColor: AppColors.dirtyWhite,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          fontFamily: AppFonts.onest,
          color: AppColors.black,
        ),
      ),
      elevatedButtonTheme: AppThemeConfigs.getElevatedButtonTheme(
        backgroundColor: mainColorConfig.primaryColor,
      ),
      dividerTheme: DividerThemeData(
        color: colorSchemeConfig.secondary,
      ),
      outlinedButtonTheme: AppThemeConfigs.getOutlinedButtonTheme(
        sideColor: mainColorConfig.primaryColor,
        foregroundColor: mainColorConfig.primaryColor,
        backgroundColor: mainColorConfig.primaryDarkColor,
      ),
      bottomNavigationBarTheme: AppThemeConfigs.getBottomNavTheme(
        selectedItemColor: mainColorConfig.primaryColor,
      ),
      navigationBarTheme: AppThemeConfigs.getNavBarTheme(
        selectedIconColor: mainColorConfig.primaryColor,
        selectedLabelColor: mainColorConfig.primaryColor,
        indicatorColor: mainColorConfig.secondaryDarkColor,
        shadowColor: mainColorConfig.secondaryDarkColor,
        overlayColor: mainColorConfig.secondaryDarkColor,
        backgroundColor: AppColors.fullWhite,
      ),
      checkboxTheme: AppThemeConfigs.getCheckboxTheme(
        selectedItemColor: mainColorConfig.primaryColor,
      ),
      inputDecorationTheme: AppThemeConfigs.getInputDecorationTheme(),
      chipTheme: AppThemeConfigs.getChipTheme(
        backgroundColor: mainColorConfig.primaryColor,
        sideColor: mainColorConfig.primaryColor,
      ),
      colorScheme: colorSchemeConfig,
      extensions: [
        ThemeTextStyles.light,
        ColorSchemeColors.light,
      ],
    );
  }
}

@immutable
class AppThemeConfigs {
  const AppThemeConfigs._();

  static ElevatedButtonThemeData getElevatedButtonTheme({
    required Color backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor ?? AppColors.white,
        disabledBackgroundColor: disabledBackgroundColor ?? AppColors.gray,
        disabledForegroundColor: disabledForegroundColor ?? AppColors.belleGray,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.onest,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.radiusMedium),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingLarge,
          horizontal: AppDimensions.paddingLarge,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData getOutlinedButtonTheme({
    required Color sideColor,
    required Color foregroundColor,
    required Color backgroundColor,
    Color? disabledSideColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
  }) {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.resolveWith((_) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimensions.radiusMedium),
            ),
          );
        }),
        side: WidgetStateBorderSide.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(
                  color: disabledSideColor ?? AppColors.belleGray);
            }
            return BorderSide(color: sideColor);
          },
        ),
        foregroundColor: WidgetStateColor.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledForegroundColor ?? AppColors.belleGray;
            }
            return foregroundColor;
          },
        ),
        backgroundColor: WidgetStateColor.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledBackgroundColor ?? AppColors.gray;
            }
            return backgroundColor;
          },
        ),
        textStyle: const WidgetStatePropertyAll<TextStyle>(
          TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.onest,
          ),
        ),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: AppDimensions.paddingLarge,
            horizontal: AppDimensions.paddingLarge,
          ),
        ),
      ),
    );
  }

  static BottomNavigationBarThemeData getBottomNavTheme({
    required Color selectedItemColor,
    Color? unselectedItemColor,
  }) {
    return BottomNavigationBarThemeData(
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? AppColors.gray,
    );
  }

  static CheckboxThemeData getCheckboxTheme({
    required Color selectedItemColor,
    Color? unselectedItemColor,
    Color? borderSideColor,
    Color? errorSideColor,
  }) {
    return CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll<Color>(AppColors.white),
      fillColor: WidgetStateColor.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return selectedItemColor;
          }
          return unselectedItemColor ?? AppColors.white;
        },
      ),
      side: WidgetStateBorderSide.resolveWith((states) {
        Color color = borderSideColor ?? AppColors.white;
        if (states.contains(WidgetState.error)) {
          color = errorSideColor ?? AppColors.red;
        }
        if (states.contains(WidgetState.selected)) {
          color = selectedItemColor;
        }
        return BorderSide(
          color: color,
          width: 0.7,
        );
      }),
    );
  }

  static NavigationBarThemeData getNavBarTheme({
    required Color indicatorColor,
    required Color shadowColor,
    required Color overlayColor,
    required Color selectedLabelColor,
    required Color selectedIconColor,
    Color? backgroundColor,
    Color? unselectedLabelColor,
    Color? unselectedIconColor,
  }) {
    return NavigationBarThemeData(
      backgroundColor: backgroundColor ?? AppColors.lightBlack,
      indicatorColor: indicatorColor,
      shadowColor: shadowColor,
      overlayColor: WidgetStatePropertyAll<Color>(overlayColor),
      labelTextStyle:
          WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: selectedLabelColor,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          );
        }
        return TextStyle(
          color: unselectedLabelColor ?? AppColors.gray,
          fontSize: 12.0,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: selectedIconColor,
          );
        }
        return IconThemeData(
          color: unselectedIconColor ?? AppColors.gray,
        );
      }),
    );
  }

  static InputDecorationTheme getInputDecorationTheme({
    Color? borderColor,
    Color? prefixLabelColor,
    Color? labelColor,
    Color? hintColor,
  }) {
    return InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusMedium),
        ),
        borderSide: BorderSide(
          color: borderColor ?? AppColors.lightGray,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusMedium),
        ),
        borderSide: BorderSide(
          color: borderColor ?? AppColors.lightGray,
        ),
      ),
      prefixStyle: TextStyle(
        color: prefixLabelColor ?? AppColors.lightGray,
        fontFamily: AppFonts.onest,
        fontSize: 16.0,
      ),
      labelStyle: TextStyle(
        color: labelColor,
        fontFamily: AppFonts.onest,
        fontSize: 14.0,
      ),
      hintStyle: TextStyle(
        fontSize: 13.0,
        color: hintColor ?? AppColors.lightGray,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static ChipThemeData getChipTheme({
    required Color backgroundColor,
    Color? iconColor,
    required Color sideColor,
    Color? labelColor,
  }) {
    return ChipThemeData(
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(
        color: iconColor ?? AppColors.white,
      ),
      side: BorderSide(
        color: sideColor,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.radiusGiant),
        ),
      ),
      elevation: 0.0,
      labelStyle: TextStyle(
        color: labelColor ?? AppColors.white,
        fontFamily: AppFonts.onest,
      ),
    );
  }

  static FloatingActionButtonThemeData getFloatingActionButtonThemeData({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return FloatingActionButtonThemeData(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: const CircleBorder(),
    );
  }
}

class ColorSchemeConfig {
  static ColorScheme darkScheme(MainColorConfig mainColorConfig) =>
      ColorScheme.fromSeed(
        seedColor: mainColorConfig.primaryColor,
        brightness: Brightness.dark,
        error: AppColors.red,
      ).copyWith(
        // primary color
        primary: mainColorConfig.primaryColor,
        // little lighter than primary
        primaryContainer: mainColorConfig.primaryLightColor,
        // foreground of primary
        onPrimary: AppColors.fullWhite,
        // most UI
        secondary: AppColors.belleGray,
        // foreground of secondary
        onSecondary: AppColors.lightGray,
        // little lighter than secondary, for example, disabled widgets
        secondaryContainer: AppColors.gray,
        // background
        surface: AppColors.black,
        // foreground of background
        onSurface: AppColors.fullWhite,
        // little lighter than surface, secondary background
        surfaceContainer: AppColors.darkPinkDark,
      );

  static ColorScheme lightScheme(MainColorConfig mainColorConfig) =>
      ColorScheme.fromSeed(
        seedColor: mainColorConfig.primaryColor,
        brightness: Brightness.light,
        error: AppColors.red,
      ).copyWith(
        // primary color
        primary: mainColorConfig.primaryColor,
        // little lighter than primary
        primaryContainer: mainColorConfig.primaryLightColor,
        // foreground of primary
        onPrimary: AppColors.black,
        // most UI
        secondary: AppColors.lightGray,
        // foreground of secondary
        onSecondary: AppColors.black,
        // little lighter than secondary, for example, disabled widgets
        secondaryContainer: AppColors.dirtyWhite,
        // background
        surface: AppColors.fullWhite,
        // foreground of background
        onSurface: AppColors.black,
        // little lighter than surface, secondary background
        surfaceContainer: AppColors.dirtyWhite,
      );
}
