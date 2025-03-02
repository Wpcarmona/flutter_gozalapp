import 'package:formz/formz.dart';

enum DocumentTypeError { empty, invalid }

class DocumentType extends FormzInput<String, DocumentTypeError> {
  static const List<String> validTypes = [
    'CC', 'CE', 'CD', 'PA', 'SC', 'PE', 'RC', 'TI', 'Cn'
  ];

  const DocumentType.pure() : super.pure('');
  const DocumentType.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == DocumentTypeError.empty) return 'El campo es obligatorio';
    if (displayError == DocumentTypeError.invalid) return 'Tipo de documento no válido';

    return null;
  }

  @override
  DocumentTypeError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DocumentTypeError.empty;
    if (!validTypes.contains(value)) return DocumentTypeError.invalid;

    return null;
  }
}
