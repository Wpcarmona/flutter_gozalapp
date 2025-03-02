import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:gozalapp/infraestructure/inputs/otp.dart';
import 'package:gozalapp/presentation/providers/auth/auth_provider.dart';

// Estado del formulario
enum FormOtpStatus { invalid, valid, validating, posting }

final otpFormProvider =
    StateNotifierProvider.autoDispose<OtpFormNotifier, OtpFormState>((ref) {

    final otpCallback = ref.watch(authProvider.notifier).verifyPhone;
  return OtpFormNotifier(verifyOtpCallback:otpCallback);
});

class OtpFormNotifier extends StateNotifier<OtpFormState> {

  final Function(String) verifyOtpCallback;

  OtpFormNotifier({required this.verifyOtpCallback}) : super(OtpFormState());

  void onOtpChanged(String value) {
    final otp = Otp.dirty(value);
    state = state.copyWith(
      otp: otp,
      isValid: Formz.validate([otp]),
    );
  }

  void onFormSubmit() async {
    if (!state.isValid) return;
    state = state.copyWith(formStatus: FormOtpStatus.validating);
    await verifyOtpCallback(state.otp.value);
    state = state.copyWith(formStatus: FormOtpStatus.valid);
  }
}

class OtpFormState {
  final FormOtpStatus formStatus;
  final bool isValid;
  final Otp otp;

  const OtpFormState({
    this.formStatus = FormOtpStatus.invalid,
    this.isValid = false,
    this.otp = const Otp.pure(),
  });

  OtpFormState copyWith({
    FormOtpStatus? formStatus,
    bool? isValid,
    Otp? otp,
  }) {
    return OtpFormState(
      formStatus: formStatus ?? this.formStatus,
      isValid: isValid ?? this.isValid,
      otp: otp ?? this.otp,
    );
  }
}
