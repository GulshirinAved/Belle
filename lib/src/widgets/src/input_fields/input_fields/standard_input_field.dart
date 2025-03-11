import 'package:flutter/material.dart';

import '../props/standard_input_field_props.dart';

class StandardInputField extends StatefulWidget {
  final StandardInputFieldProps props;
  const StandardInputField({super.key, required this.props});

  @override
  State<StandardInputField> createState() => _StandardInputFieldState();
}

class _StandardInputFieldState extends State<StandardInputField> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.props.validator,
      controller: widget.props.textEditingController,
      initialValue: widget.props.initialValue,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUnfocus,

      onTapOutside: (_) {
        focusNode.unfocus();
      },
      enabled: widget.props.enabled,
      keyboardType: widget.props.keyboardType,
      inputFormatters: widget.props.inputFormatters,
      maxLines: widget.props.maxLines,
      decoration: InputDecoration(
        counter: const SizedBox(),
        labelText: widget.props.labelText,
        prefixText: widget.props.prefixText,
        hintText: widget.props.hintText,
      ),
    );
  }
}
