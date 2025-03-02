import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:gozalapp/infraestructure/inputs/inputs.dart';
import 'package:gozalapp/presentation/providers/auth/auth_provider.dart';

// final loginFormProvider = StateNotifierProvider.autoDispose<
enum FormStatus { invalid, valid, validating, posting }

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;

  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({required this.loginUserCallback})
      : super(LoginFormState());

  onNumerDocumentChanged(String value) {
    final numberDocument = NumberDocument.dirty(value);
    state = state.copyWith(
        numberDocument: numberDocument,
        isValid: Formz.validate([numberDocument, state.password]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.numberDocument]));
  }

  onFormSubmit() async {
    if (!state.isValid) return;
    state = state.copyWith(formStatus: FormStatus.validating);
     await loginUserCallback(state.numberDocument.value, state.password.value);
    state = state.copyWith(formStatus:FormStatus.valid);
  }
}

class LoginFormState {
  final FormStatus formStatus;
  final bool isValid;
  final NumberDocument numberDocument;
  final Password password;

  const LoginFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.numberDocument = const NumberDocument.pure(),
    this.password = const Password.pure(),
  });

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

  // @override
  // List<Object> get props => [formStatus, isValid, numberDocument, password];
}
