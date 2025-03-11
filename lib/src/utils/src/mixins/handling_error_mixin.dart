import 'dart:developer';

import 'package:belle/src/utils/src/helpers/show_snack_helper.dart';
import 'package:flutter/material.dart';

mixin HandlingErrorMixin {
  BuildContext? _context;

  BuildContext? get handleContext => _context;

  void setContext(BuildContext context) {
    debugPrint('context is set: $context');
    _context = context;
  }

  void disposeContext() {
    _context = null;
  }

  void handleError(String errorMessage) {
    // assert(_context != null, 'Error: BuildContext is not set.');
    if (_context != null) {
      ShowSnackHelper.showSnack(_context!, SnackStatus.error, errorMessage);
    } else {
      log('Error: BuildContext is not set.');
    }
  }

  void handleSuccess([String? successMessage]) {
    assert(_context != null, 'Error: BuildContext is not set.');
    if (_context != null) {
      ShowSnackHelper.showSnack(_context!, SnackStatus.success, successMessage);
    } else {
      log('Error: BuildContext is not set.');
    }
  }
}
