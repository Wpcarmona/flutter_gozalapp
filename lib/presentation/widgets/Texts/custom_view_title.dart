import 'package:flutter/material.dart';

class CustomViewTitle extends StatelessWidget {

  final String text;
  final TextAlign textAlign;
  const CustomViewTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: (0)),
      child: Text(
        text,
        textAlign: textAlign,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 22,
          height: 1.2,
          fontWeight: FontWeight.w800,
          letterSpacing:  0,
          color: Color(0xFF5C5C5C)
        ),
      ),
    );
  }
}