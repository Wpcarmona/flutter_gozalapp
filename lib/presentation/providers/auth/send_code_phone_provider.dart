


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gozalapp/presentation/providers/auth/auth_provider.dart';

enum FormSendCodePhoneStatus { initial, loading, success, error }


final sendCodeFormProvider = StateNotifierProvider.autoDispose<SendCodePhoneNotifier,SenndCodePhoneState>((ref){

  final sendCodePhoneCallback = ref.watch(authProvider.notifier).resendVerifyPhone;

  return SendCodePhoneNotifier(sendCodePhoneCallback: sendCodePhoneCallback);
});

class SendCodePhoneNotifier extends StateNotifier<SenndCodePhoneState> {
  final Function() sendCodePhoneCallback;

  SendCodePhoneNotifier({
    required this.sendCodePhoneCallback
  }): super(SenndCodePhoneState());

  void onFormSubmit() async {
    
    await sendCodePhoneCallback();
   
  }

}


class SenndCodePhoneState {
  final FormSendCodePhoneStatus formStatus;
  final bool isValid;

  SenndCodePhoneState({
    this.formStatus = FormSendCodePhoneStatus.initial,
    this.isValid = false,
  });

  SenndCodePhoneState copyWith({
    FormSendCodePhoneStatus? formStatus,
    bool? isValid,
  }) {
    return SenndCodePhoneState(
      formStatus: formStatus ?? this.formStatus,
      isValid: isValid ?? this.isValid,
    );
  }
}