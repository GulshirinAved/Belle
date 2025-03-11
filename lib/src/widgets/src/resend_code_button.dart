import 'dart:async';

import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';

class ResendCodeButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ResendCodeButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  Timer? timer;
  int seconds = 5;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (seconds > 0) {
      return OutlinedButton(
        onPressed: null,
        child: Text(
            '${context.loc.send_code_again} 00:${seconds.toString().padLeft(2, '0')}'),
      );
    }
    return OutlinedButton(
      onPressed: () {
        widget.onPressed();
        refreshTimer();
      },
      child: Text(context.loc.resend_code),
    );
  }

  void refreshTimer() {
    seconds = 59;
    setState(() {});
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (value) {
        setState(() {
          seconds--;
        });
        if (seconds == 0) {
          timer?.cancel();
        }
      },
    );
  }
}
