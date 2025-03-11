import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../props/phone_input_field_props.dart';
import 'package:belle/src/utils/utils.dart';

class PhoneInputField extends StatefulWidget {
  final PhoneInputFieldProps props;

  const PhoneInputField({super.key, required this.props});

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.props.enabled,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: ValidationBuilder(
        localeName: context.loc.localeName,
      ).minLength(8).add((value) {
        final phone = (int.tryParse(value ?? '0') ?? 0);
        if (phone < 61000000 || phone > 71999999) {
          return context.loc.phone_between('61000000', '71999999');
        }
        return null;
      }).build(),
      maxLength: 8,
      controller: widget.props.textEditingController,
      focusNode: focusNode,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        counter: const SizedBox(),
        labelText: widget.props.labelText ?? context.loc.phone_number,
        prefixText: '+993 | ',
      ),
    );
  }
}
