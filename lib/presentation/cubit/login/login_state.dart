part of 'login_cubit.dart';

enum FormStatus {invalid, valid, validating, posting}

class LoginFormState extends Equatable {

  final FormStatus formStatus;
  final bool isValid;
  final NumberDocument numberDocument;
  final Password password;

  const LoginFormState({
    this.formStatus = FormStatus.invalid, 
    this.isValid = false, 
    this.numberDocument = const NumberDocument.pure(), 
    this.password = const Password.pure() });

  LoginFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    NumberDocument? numberDocument,
    Password? password,
  }) {
    return LoginFormState(
      formStatus: formStatus ?? this.formStatus,
      isValid: isValid ?? this.isValid,
      numberDocument: numberDocument ?? this.numberDocument,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [formStatus, isValid, numberDocument, password];
}

