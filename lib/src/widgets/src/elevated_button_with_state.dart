import 'package:flutter/material.dart';

class ElevatedButtonWithState extends StatelessWidget {
  final bool isLoading;
  final bool? isError;
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final double? height;
  final double? width;
  final VisualDensity? visualDensity;

  const ElevatedButtonWithState({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.isError,
    this.height,
    this.width,
    this.style,
    this.visualDensity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style ??
            ElevatedButton.styleFrom(
              visualDensity: visualDensity,
              backgroundColor: null,
            ),
        child: _getState(context),
      ),
    );
  }

  Widget _getState(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 20.0,
        width: 20.0,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.0,
          ),
        ),
      );
    }
    return child;
  }
}

class OutlinedButtonWithState extends StatelessWidget {
  final bool isLoading;
  final bool? isError;
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final double? height;
  final double? width;
  final VisualDensity? visualDensity;

  const OutlinedButtonWithState({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.isError,
    this.height,
    this.width,
    this.style,
    this.visualDensity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: style ??
            OutlinedButton.styleFrom(
              visualDensity: visualDensity,
              backgroundColor: null,
            ),
        child: _getState(context),
      ),
    );
  }

  Widget _getState(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 20.0,
        width: 20.0,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.0,
          ),
        ),
      );
    }
    return child;
  }
}

// Базовый класс для Elevated Button
class LoadingElevatedButton extends ElevatedButton {
  final bool isLoading;

  LoadingElevatedButton({
    super.key,
    required super.onPressed,
    required Widget child,
    this.isLoading = false,
    super.style,
  }) : super(
          child: _getState(isLoading, child),
        );

  static Widget _getState(bool isLoading, Widget child) {
    if (isLoading) {
      return const SizedBox(
        height: 20.0,
        width: 20.0,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.0,
          ),
        ),
      );
    }
    return child;
  }
}

// Базовый класс для Outlined Button
class LoadingOutlinedButton extends OutlinedButton {
  final bool isLoading;

  LoadingOutlinedButton({
    super.key,
    required super.onPressed,
    required Widget child,
    this.isLoading = false,
    super.style,
  }) : super(
          child: _getState(isLoading, child),
        );

  static Widget _getState(bool isLoading, Widget child) {
    if (isLoading) {
      return const SizedBox(
        height: 20.0,
        width: 20.0,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.0,
          ),
        ),
      );
    }
    return child;
  }
}

// Extension Methods для удобства (опционально)
extension ButtonX on Widget {
  static Widget elevated({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    bool isLoading = false,
    ButtonStyle? style,
  }) {
    return LoadingElevatedButton(
      key: key,
      onPressed: onPressed,
      isLoading: isLoading,
      style: style,
      child: child,
    );
  }

  static Widget outlined({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    bool isLoading = false,
    ButtonStyle? style,
  }) {
    return LoadingOutlinedButton(
      key: key,
      onPressed: onPressed,
      isLoading: isLoading,
      style: style,
      child: child,
    );
  }
}
