import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StandardInputFieldProps {
  final String? labelText;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? hintText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool enabled;
  final String? initialValue;

  const StandardInputFieldProps({
    this.labelText,
    this.textEditingController,
    this.keyboardType,
    this.inputFormatters,
    this.prefixText,
    this.hintText,
    this.validator,
    this.maxLines,
    this.enabled = true,
    this.initialValue,
  });
}
