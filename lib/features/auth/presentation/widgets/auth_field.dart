import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String text;
  final bool xpand;
  final bool isObscure;
  final TextEditingController controller;

  static _field(BuildContext context, String text,
          TextEditingController controller, bool isObscure) =>
      TextFormField(
        onTapOutside: (PointerDownEvent event) {
          FocusScope.of(context).unfocus();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return '$text is missing!';
          }
          return null;
        },
        controller: controller,
        style: const TextStyle(
            fontFamily: 'Britanica Expanded Black',
            color: AppPalette.primaryColor,
            fontSize: 13),
        decoration: InputDecoration(
          hintText: text,
        ),
        obscureText: isObscure,
      );

  const AuthField({
    super.key,
    required this.text,
    required this.xpand,
    required this.controller,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    if (xpand) {
      return Expanded(
        child: _field(context, text, controller, isObscure),
      );
    } else {
      return _field(context, text, controller, isObscure);
    }
  }
}
