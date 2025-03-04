import 'package:formz/formz.dart';

enum TagError { empty }

class Tag extends FormzInput<String, TagError> {
  const Tag.pure() : super.pure('');
  const Tag.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == TagError.empty) return 'El tag no puede estar vacío';
    
    return null;
  }

  @override
  TagError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TagError.empty;
    
    return null;
  }
}
