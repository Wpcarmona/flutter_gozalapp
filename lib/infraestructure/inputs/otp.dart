import 'package:formz/formz.dart';

enum OtpError { empty, invalidLength }

class Otp extends FormzInput<String, OtpError> {
  static const int requiredLength = 6; // Longitud esperada del OTP

  const Otp.pure() : super.pure('');

  const Otp.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == OtpError.empty) return 'El código es obligatorio';
    if (displayError == OtpError.invalidLength) return 'El código debe tener $requiredLength dígitos';

    return null;
  }

  @override
  OtpError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return OtpError.empty;
    if (value.length != requiredLength) return OtpError.invalidLength;

    return null;
  }
}
