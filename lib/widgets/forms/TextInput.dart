import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Function onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String initialValue;
  final String errorText;
  final String helperText;
  final Icon prefixIcon;
  final Widget suffixIcon;
  final bool isSecret;

  const TextInput({
    Key key,
    @required this.label,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.errorText,
    this.helperText,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.isSecret = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: TextFormField(
        obscureText: isSecret,
        textInputAction: TextInputAction.next,
        initialValue: initialValue ?? null,
        focusNode: focusNode ?? null,
        controller: controller ?? null,
        onChanged: onChanged ?? null,
        decoration: InputDecoration(
          helperText: helperText ?? null,
          prefixIcon: prefixIcon ?? null,
          suffixIcon: suffixIcon ?? null,
          errorText: errorText ?? null,
          errorMaxLines: 2,
          helperMaxLines: 2,
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
