import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomInputList extends StatelessWidget {
  final String? label;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  final List<String> items;
  final String? errorMessage;

  const CustomInputList({
    super.key,
    required this.items,
    this.label,
    this.selectedValue,
    this.onChanged,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

    return DropdownButtonFormField2<String>(
      value: selectedValue,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: border.copyWith(
          borderSide: const BorderSide(color: Color(0xFFFBE9DC), width: 1),
        ),
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: Color(0xFFFFC942), width: 1),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error, width: 1),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: label,
        errorText: errorMessage, // Se muestra si hay un error
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 15),
      ),
      items: items
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: onChanged, // Se pasa la función correctamente
    );
  }
}
