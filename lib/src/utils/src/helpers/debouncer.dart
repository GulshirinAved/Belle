import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Timer? _debounce;

  Future<void> debounce({
    required bool isEmpty,
    required VoidCallback emptyCallback,
    required VoidCallback successCallback,
    Duration? duration,
  }) async {
    _debounce?.cancel();

    if (isEmpty) {
      emptyCallback.call();
    } else {
      _debounce = Timer(const Duration(seconds: 1), () {
        if (isEmpty) {
          emptyCallback.call();
        } else {
          successCallback();
        }
      });
    }
  }

  void dispose() {
    _debounce?.cancel();
  }
}
