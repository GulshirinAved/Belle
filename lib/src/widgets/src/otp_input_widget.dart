import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../theme/theme.dart';
import '../widgets.dart';

class OtpInputWidget extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final Function(String?)? onError;
  final String? Function(String?) validator;
  final TextEditingController controller;

  const OtpInputWidget({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.onError,
    required this.validator,
    required this.controller,
  });

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  String _currentOtp = '';
  void _handleCompleted(String value) {
    setState(() {
      _currentOtp = value;
      String? errorMessage = widget.validator(_currentOtp);

      if (errorMessage != null) {
        widget.onError?.call(errorMessage);
      } else {
        widget.onCompleted(_currentOtp);
      }
    });
  }

  void _onChanged(String value) {
    setState(() {
      _currentOtp = value;
      // _hasStartedInput = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      // width: 56,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleMedium,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return FormField(
      validator: (value) {
        return widget.validator(widget.controller.text);
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Pinput(
              length: widget.length,
              controller: widget.controller,
              defaultPinTheme: defaultPinTheme,
              onCompleted: _handleCompleted,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              showCursor: true,
              onChanged: _onChanged,
            ),
            if (state.hasError) ...[
              const VSpacer(AppDimensions.paddingMedium),
              Text(context.loc.required),
            ],
          ],
        );
      },
    );
  }
}
