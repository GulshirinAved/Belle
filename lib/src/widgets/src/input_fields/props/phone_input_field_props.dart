import 'package:flutter/material.dart';

class PhoneInputFieldProps {
  final String? labelText;
  final TextEditingController? textEditingController;
  final bool enabled;

  const PhoneInputFieldProps( {
    this.labelText,
    this.textEditingController,
    this.enabled = true,
  });
}
