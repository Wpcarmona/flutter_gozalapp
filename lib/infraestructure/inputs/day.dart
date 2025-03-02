import 'package:formz/formz.dart';

enum DayError { empty, invalid }

class Day extends FormzInput<String, DayError> {
  const Day.pure() : super.pure('');
  const Day.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == DayError.empty) return 'El día es obligatorio';
    if (displayError == DayError.invalid) return 'El día debe estar entre 1 y 31';

    return null;
  }

  @override
  DayError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DayError.empty;
    final int? day = int.tryParse(value);
    if (day == null || day < 1 || day > 31) return DayError.invalid;

    return null;
  }
}
