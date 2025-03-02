import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:gozalapp/infraestructure/inputs/inputs.dart';
import 'package:gozalapp/presentation/providers/providers.dart';

enum FormRegisterStatus { invalid, valid, validating, posting }

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
  ) registerUserCallback;

  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  void onStepSubmit() {
    final isStepValid = Formz.validate([
      state.name,
      state.email,
      state.numberDocument,
      state.typeDocument,
      state.phone,
      state.countryCode,
      state.day,
      state.month,
      state.year,
      state.password,
      // state.termsAndConditions
    ]);

    state = state.copyWith(
      formStatus:
          isStepValid ? FormRegisterStatus.valid : FormRegisterStatus.invalid,
      isStepValid: isStepValid,
    );
  }

  onFormSubmit() async {
    if (!state.isValid) return;
    state = state.copyWith(formStatus: FormRegisterStatus.validating);
    await registerUserCallback(
        state.email.value,
        state.typeDocument.value,
        state.numberDocument.value,
        state.password.value,
        state.passwordConfirmation.value,
        state.phone.value,
        state.countryCode.value,
        state.name.value,
        state.day.value,
        state.month.value,
        state.year.value);
    state = state.copyWith(formStatus: FormRegisterStatus.valid);
  }

  onUsernameChange(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
        name: newUsername,
        isValid: Formz.validate([
          newUsername,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          newUsername,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([
          state.name,
          newEmail,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          newEmail,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onNumerDocumentChange(String value) {
    final newNumberDocument = NumberDocument.dirty(value);
    state = state.copyWith(
        numberDocument: newNumberDocument,
        isValid: Formz.validate([
          state.name,
          state.email,
          newNumberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          state.email,
          newNumberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onTypeDocumentChange(String value) {
    final newTypeDocument = DocumentType.dirty(value);
    state = state.copyWith(
        typeDocument: newTypeDocument,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          newTypeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          newTypeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onPhoneChange(String value) {
    final newPhone = PhoneNumberInput.dirty(value);
    state = state.copyWith(
        phone: newPhone,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          newPhone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          newPhone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onCountryCodeChange(String value) {
    final newCountryCode = CountryCode.dirty(value);
    state = state.copyWith(
        countryCode: newCountryCode,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          newCountryCode,
          state.day,
          state.month,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          newCountryCode,
          state.day,
          state.month,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onDayChange(String value) {
    final newDay = Day.dirty(value);
    state = state.copyWith(
        day: newDay,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          newDay,
          state.month,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          newDay,
          state.month,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onMonthChange(String value) {
    final newMonth = Month.dirty(value);
    state = state.copyWith(
        month: newMonth,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          newMonth,
          state.year,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          newMonth,
          state.year,
          // state.termsAndConditions
        ]));
  }

  onYearChange(String value) {
    final newYear = Year.dirty(value);
    state = state.copyWith(
        year: newYear,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          newYear,
          state.password,
          state.passwordConfirmation,
          // state.termsAndConditions
        ]),
        isStepValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          newYear,
          // state.termsAndConditions
        ]));
  }

void onPasswordChange(String value) {
  final newPassword = Password.dirty(value);

  // Verificaciones
  final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
  final hasMinLength = value.length >= 8;
  final hasSpecialCharOrNumber = RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]').hasMatch(value);

  state = state.copyWith(
    password: newPassword,
    hasUpperCase: hasUppercase,
    hasMinLength: hasMinLength,
    hasSpecialCharOrNumber: hasSpecialCharOrNumber,
    isValid: Formz.validate([
      state.name,
      state.email,
      state.numberDocument,
      state.typeDocument,
      state.phone,
      state.countryCode,
      state.day,
      state.month,
      state.year,
      newPassword,
      state.passwordConfirmation,
      // state.termsAndConditions
    ]),
  );
}


  onPasswordConfirmationChange(String value) {
    final newPasswordConfirmation = ConfirmPassword.dirty(
        value: value, originalPassword: state.password.value);

    state = state.copyWith(
        passwordConfirmation: newPasswordConfirmation,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.numberDocument,
          state.typeDocument,
          state.phone,
          state.countryCode,
          state.day,
          state.month,
          state.year,
          state.password,
          newPasswordConfirmation,
          // state.termsAndConditions
        ]));
  }

// void onTermsAndConditionsChange(bool value) {
//   final newTermsAndConditions = TermsAndConditions.dirty(value);

//   state = state.copyWith(
//     termsAndConditions: newTermsAndConditions,
//     isValid: Formz.validate([
//       state.name,
//       state.email,
//       state.numberDocument,
//       state.typeDocument,
//       state.phone,
//       state.countryCode,
//       state.day,
//       state.month,
//       state.year,
//       newTermsAndConditions,
//     ]),
//   );
// }
}

class RegisterFormState {
  final FormRegisterStatus formStatus;
  final bool isValid;
  final bool isStepValid;
  final Username name;
  final Email email;
  final NumberDocument numberDocument;
  final DocumentType typeDocument;
  final PhoneNumberInput phone;
  final CountryCode countryCode;
  final Day day;
  final Month month;
  final Year year;
  final String? referralCode;
  final Password password;
  final ConfirmPassword passwordConfirmation;
  // final TermsAndConditions termsAndConditions;
  final bool hasUpperCase;
  final bool hasMinLength;
  final bool hasSpecialCharOrNumber;

  RegisterFormState({
    this.formStatus = FormRegisterStatus.valid,
    this.isValid = false,
    this.isStepValid = false,
    this.name = const Username.pure(),
    this.email = const Email.pure(),
    this.numberDocument = const NumberDocument.pure(),
    this.typeDocument = const DocumentType.pure(),
    this.phone = const PhoneNumberInput.pure(),
    this.countryCode = const CountryCode.pure(),
    this.day = const Day.pure(),
    this.month = const Month.pure(),
    this.year = const Year.pure(),
    this.referralCode,
    this.password = const Password.pure(),
    this.passwordConfirmation = const ConfirmPassword.pure(),
    //  this.termsAndConditions = const TermsAndConditions.dirty(false)
    this.hasUpperCase = false,
    this.hasMinLength = false,
    this.hasSpecialCharOrNumber = false,
  });

  RegisterFormState copyWith({
    FormRegisterStatus? formStatus,
    bool? isValid,
    bool? isStepValid,
    Username? name,
    Email? email,
    NumberDocument? numberDocument,
    DocumentType? typeDocument,
    PhoneNumberInput? phone,
    CountryCode? countryCode,
    Day? day,
    Month? month,
    Year? year,
    String? referralCode,
    Password? password,
    ConfirmPassword? passwordConfirmation,
    //  TermsAndConditions? termsAndConditions,
    bool? hasUpperCase,
    bool? hasMinLength,
    bool? hasSpecialCharOrNumber,
  }) =>
      RegisterFormState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        isStepValid: isStepValid ?? this.isValid,
        name: name ?? this.name,
        email: email ?? this.email,
        numberDocument: numberDocument ?? this.numberDocument,
        typeDocument: typeDocument ?? this.typeDocument,
        phone: phone ?? this.phone,
        countryCode: countryCode ?? this.countryCode,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
        referralCode: referralCode ?? this.referralCode,
        password: password ?? this.password,
        passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
        //  termsAndConditions: termsAndConditions ?? this.termsAndConditions
      hasUpperCase: hasUpperCase ?? this.hasUpperCase,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasSpecialCharOrNumber: hasSpecialCharOrNumber ?? this.hasSpecialCharOrNumber,
      );
}
