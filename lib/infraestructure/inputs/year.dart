import 'package:formz/formz.dart';

enum YearError { empty, invalid }

class Year extends FormzInput<String, YearError> {
  const Year.pure() : super.pure('');
  const Year.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == YearError.empty) return 'El año es obligatorio';
    if (displayError == YearError.invalid) return 'El año debe estar entre 1990 y 2025';

    return null;
  }

  @override
  YearError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return YearError.empty;
    final int? year = int.tryParse(value);
    if (year == null || year < 1990 || year > 2025) return YearError.invalid;

    return null;
  }
}
