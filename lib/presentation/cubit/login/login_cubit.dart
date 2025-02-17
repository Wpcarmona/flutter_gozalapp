import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gozalapp/infraestructure/inputs/inputs.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginFormState> {
  LoginCubit() : super(const LoginFormState());

  void onSubmit() {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        numberDocument: NumberDocument.dirty(state.numberDocument.value),
        password: Password.dirty(state.password.value),

        isValid: Formz.validate([state.numberDocument, state.password]),
      )
    );
  }

  void numberDocumentChanged(String value) {
    final numberDocument = NumberDocument.dirty(value);
    emit(
      state.copyWith(
        numberDocument: numberDocument,
        isValid: Formz.validate([numberDocument, state.password]),
      )
    );
  }

    void passwordChanged(String value){
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password,state.numberDocument])
      )
    );
  }
}
