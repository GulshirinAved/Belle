import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:belle/src/core/core.dart';
import 'package:belle/src/utils/utils.dart';

import '../props/password_input_field_props.dart';

class PasswordInputField extends StatefulWidget {
  final PasswordInputFieldProps props;

  const PasswordInputField({super.key, required this.props});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  final focusNode = FocusNode();
  bool obscureText = true;

  void updateObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidationBuilder(
        localeName: context.loc.localeName,
      ).minLength(8).build(),
      controller: widget.props.textEditingController,
      focusNode: focusNode,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        counter: const SizedBox(),
        labelText: widget.props.labelText ?? context.loc.password,
        suffixIcon: IconButton(
          onPressed: updateObscureText,
          icon:
              Icon(obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
        ),
      ),
    );
  }
}
