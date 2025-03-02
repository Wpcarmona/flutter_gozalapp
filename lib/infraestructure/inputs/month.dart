import 'package:formz/formz.dart';

enum MonthError { empty, invalid }

class Month extends FormzInput<String, MonthError> {
  const Month.pure() : super.pure('');
  const Month.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == MonthError.empty) return 'El mes es obligatorio';
    if (displayError == MonthError.invalid) return 'El mes debe estar entre 1 y 12';

    return null;
  }

  @override
  MonthError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return MonthError.empty;
    final int? month = int.tryParse(value);
    if (month == null || month < 1 || month > 12) return MonthError.invalid;

    return null;
  }
}
