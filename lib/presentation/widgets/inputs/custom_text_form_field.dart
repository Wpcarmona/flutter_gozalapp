import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChanged,
      this.validator,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true, 
        fillColor: Colors.white, 
        enabledBorder: border.copyWith(
        borderSide: BorderSide(color: Color(0xFFFBE9DC), width: 1)),
        focusedBorder: border.copyWith( borderSide: BorderSide(color: Color(0xFFFFC942), width: 1),),
        errorBorder: border.copyWith(borderSide: BorderSide(color: colors.error, width: 1),),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: colors.error, width: 1),),
        isDense: false, 
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,   
        ),
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: errorMessage,
        focusColor: colors.primary,
      ),
    );
  }
}
