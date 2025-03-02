import 'package:formz/formz.dart';

enum PhoneNumberInputError { empty, length }

class PhoneNumberInput extends FormzInput<String, PhoneNumberInputError> {
  const PhoneNumberInput.pure() : super.pure('');

  const PhoneNumberInput.dirty(String value ) : super.dirty(value);

  String? get errorMessage {
    if(isValid || isPure) return null;
    if(displayError == PhoneNumberInputError.empty) return 'El campo es obligatorio';
    if(displayError == PhoneNumberInputError.length) return 'El campo debe tener al menos 6 caracteres';

    return null;
  
  }

  @override
  PhoneNumberInputError? validator(String value) {
    if(value.isEmpty || value.trim().isEmpty) return PhoneNumberInputError.empty;
    if(value.length < 6) return PhoneNumberInputError.length;

    return null;
  }
}