import 'package:flutter/material.dart';

typedef ValueSetter = void Function(String? value);
typedef ValueValidator = String? Function(String? value);

class CommonTextFormInput extends StatelessWidget {
  final String labelText;
  final bool? obscureText;
  final ValueSetter? valueSetter;
  final ValueValidator? valueValidator;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;

  const CommonTextFormInput({
    super.key,
    required this.labelText,
    this.valueSetter,
    this.valueValidator,
    this.obscureText,
    this.controller,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      // 键盘类型
      keyboardType: const TextInputType.numberWithOptions(
        decimal: false,
        signed: true,
      ),
      onChanged: valueSetter,
      onSaved: valueSetter,
      validator: valueValidator,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
    );
  }
}
