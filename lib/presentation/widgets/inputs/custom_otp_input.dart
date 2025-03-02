import 'package:flutter/material.dart';

class OtpInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final String? errorMessage;

  const OtpInputField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.errorMessage,
  });

  @override
  OtpInputFieldState createState() => OtpInputFieldState();
}

class OtpInputFieldState extends State<OtpInputField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index < widget.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        focusNodes[index].unfocus();
        _checkCompleted();
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  void _checkCompleted() {
    String otpCode = controllers.map((c) => c.text).join();
    if (otpCode.length == widget.length) {
      widget.onCompleted?.call(otpCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFFBE9DC), width: 1),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            return Container(
              width: 48,
              height: 52, // Ajustado para mejor alineación
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center, // Centra el texto verticalmente
                maxLength: 1,
                style: const TextStyle(
                  fontSize: 20, // Ajustado para mayor claridad
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: border,
                  focusedBorder: border.copyWith(
                    borderSide: const BorderSide(color: Color(0xFFFFC942), width: 1),
                  ),
                  errorBorder: border.copyWith(
                    borderSide: BorderSide(color: colors.error, width: 1),
                  ),
                  focusedErrorBorder: border.copyWith(
                    borderSide: BorderSide(color: colors.error, width: 1),
                  ),
                  counterText: "",
                  contentPadding: const EdgeInsets.only(bottom: 12), // Ajuste de padding
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            );
          }),
        ),
        if (widget.errorMessage != null) ...[
          const SizedBox(height: 5),
          Text(
            widget.errorMessage!,
            style: TextStyle(color: colors.error, fontSize: 14),
          ),
        ],
      ],
    );
  }
}
