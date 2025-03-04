import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gozalapp/config/constants/countryCode.dart';
import 'package:gozalapp/presentation/providers/providers.dart';
import 'package:gozalapp/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  static const name = 'register-screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBE9DC),
      body: const SafeArea(child: _RegisterView()),
    );
  }
}

class _RegisterView extends StatefulWidget implements PreferredSizeWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _RegisterViewState extends State<_RegisterView> {
  final PageController pageViewController = PageController();
  bool enReached = false;
  bool showFirstForm = true;
  int formsStep = 1;

  @override
  void initState() {
    super.initState();
    _loadStepRegister();
  }

  Future<void> _loadStepRegister() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print('beforeStep: ${prefs.getInt('StepRegister')}');
      formsStep = prefs.getInt('StepRegister') ?? 1;
      print('formsStep: $formsStep');
    });
  }

  void nextStep() {
    setState(() {
      formsStep++;
    });
  }

  void switchForm() {
    setState(() {
      showFirstForm = !showFirstForm;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/Images/background_barranquilla.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 10,
          left: 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 40,
              height: 40,
              color: const Color(0xFFFFC942),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (formsStep == 3) {
                    setState(() {
                      formsStep--;
                    });
                  } else if (formsStep == 2) {
                    setState(() {
                      formsStep--;
                    });
                  } else if (formsStep == 1) {
                    context.go('/auth/login');
                  }
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: 16,
          right: 16,
          child: CustomLinearProgressIndicator(
              formsStep: formsStep, finalStep: 4, colors: Color(0xFFFFC942)),
        ),
        Positioned(
          top: 98,
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: switch (formsStep) {
                1 => _FirstForm(onContinue: nextStep),
                2 => _SecondForm(onContinue: nextStep),
                3 => _ThirdForm(onContinue: nextStep),
                4 => _FourForm(),
                int() => throw UnimplementedError(),
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _FirstForm extends ConsumerStatefulWidget {
  final VoidCallback onContinue;
  const _FirstForm({required this.onContinue});

  @override
  ConsumerState<_FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends ConsumerState<_FirstForm> {
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String? selectedDocumentType;
  bool isReferrals = false;

  @override
  Widget build(BuildContext context) {
    final registerForm = ref.watch(registerFormProvider);
    return FadeInRight(
      duration: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
            'CHEVERE TENERTE AQUÍ!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'StenbergITC',
              fontSize: 28,
              height: 1.2,
              color: Color(0XFFEC1424),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Una experiencia carnavalera te espera. Ingresa los datos para continuar:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Komet',
              fontSize: 14,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
                label: 'Nombre completo',
                keyboardType: TextInputType.name,
                onChanged:
                    ref.read(registerFormProvider.notifier).onUsernameChange,
                errorMessage: registerForm.name.isPure
                    ? null
                    : registerForm.name.errorMessage),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                onChanged:
                    ref.read(registerFormProvider.notifier).onEmailChange,
                errorMessage: registerForm.email.isPure
                    ? null
                    : registerForm.email.errorMessage),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInputList(
                    label: "Tipo",
                    selectedValue: selectedDocumentType,
                    items: [
                      'CC',
                      'CE',
                      'CD',
                      'PA',
                      'SC',
                      'PE',
                      'RC',
                      'TI',
                      'Cn'
                    ],
                    onChanged: (value) => ref
                        .read(registerFormProvider.notifier)
                        .onTypeDocumentChange(value ?? ""),
                    errorMessage: registerForm.typeDocument.isPure
                        ? null
                        : registerForm.typeDocument.errorMessage,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                      label: 'Número de documento',
                      keyboardType: TextInputType.number,
                      onChanged: ref
                          .read(registerFormProvider.notifier)
                          .onNumerDocumentChange,
                      errorMessage: registerForm.numberDocument.isPure
                          ? null
                          : registerForm.numberDocument.errorMessage),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInputList(
                    label: "Código",
                    selectedValue: selectedDocumentType,
                    items: countryCodes,
                    onChanged: (value) => ref
                        .read(registerFormProvider.notifier)
                        .onCountryCodeChange(value ?? ""),
                    errorMessage: registerForm.countryCode.isPure
                        ? null
                        : registerForm.countryCode.errorMessage,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                      label: 'Teléfono',
                      keyboardType: TextInputType.phone,
                      onChanged:
                          ref.read(registerFormProvider.notifier).onPhoneChange,
                      errorMessage: registerForm.phone.isPure
                          ? null
                          : registerForm.phone.errorMessage),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Fecha de nacimiento',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Komet',
                fontSize: 14,
                height: 1.2,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInputList(
                      label: "Día",
                      selectedValue: selectedDay,
                      items:
                          List.generate(31, (index) => (index + 1).toString()),
                      onChanged: (value) => ref
                          .read(registerFormProvider.notifier)
                          .onDayChange(value ?? ""),
                      errorMessage: registerForm.day.isPure
                          ? null
                          : registerForm.day.errorMessage),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInputList(
                      label: "Mes",
                      selectedValue: selectedMonth,
                      items:
                          List.generate(12, (index) => (index + 1).toString()),
                      onChanged: (value) => ref
                          .read(registerFormProvider.notifier)
                          .onMonthChange(value ?? ""),
                      errorMessage: registerForm.month.isPure
                          ? null
                          : registerForm.month.errorMessage),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInputList(
                      label: "Año",
                      selectedValue: selectedYear,
                      items: List.generate(2007 - 1900 + 1,
                              (index) => (1900 + index).toString())
                          .reversed
                          .toList(),
                      onChanged: (value) => ref
                          .read(registerFormProvider.notifier)
                          .onYearChange(value ?? ""),
                      errorMessage: registerForm.year.isPure
                          ? null
                          : registerForm.year.errorMessage),
                ),
              ),
            ],
          ),
          SwitchListTile(
            title: const Text('¿Un amigo te refirió?'),
            value: isReferrals,
            activeTrackColor: const Color(0xFFFFC942),
            onChanged: (value) => setState(() {
              isReferrals = value;
            }),
          ),
          if (isReferrals)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                label: 'Código de referido',
                keyboardType: TextInputType.text,
              ),
            ),
          const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [

          //     const Text('Acepto '),
          //     GestureDetector(
          //       onTap: () {
          //         // Acción al tocar el texto
          //       },
          //       child: Text(
          //         'Términos y condiciones',
          //         style: TextStyle(
          //           color: Theme.of(context).primaryColor,
          //           decoration: TextDecoration.underline,
          //         ),
          //       ),
          //     ),
          //     const Text(' de uso'),
          //     Checkbox(
          //         value:
          //             ref.watch(registerFormProvider).termsAndConditions.value,
          //         onChanged: (bool? value) {
          //           if (value != null) {
          //             ref
          //                 .read(registerFormProvider.notifier)
          //                 .onTermsAndConditionsChange(value);
          //           }
          //         }),
          //   ],
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFFAA02),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed:
                    (registerForm.isStepValid) ? widget.onContinue : null,
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _SecondForm extends ConsumerWidget {
  final VoidCallback onContinue;
  const _SecondForm({required this.onContinue});

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);
    final registerState = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      } else {
        onContinue();
      }
    });
    return FadeInRight(
      duration: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
            'ELIGE UNA CONTRASEÑA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'StenbergITC',
              fontSize: 28,
              height: 1.2,
              color: Color(0XFFEC1424),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Crea una contraseña segura, para proteger tu cuenta y disfrutar del Carnaval sin preocupaciones.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Komet',
              fontSize: 14,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
              label: 'Contraseña',
              keyboardType: TextInputType.name,
              obscureText: true,
              onChanged:
                  ref.read(registerFormProvider.notifier).onPasswordChange,
              errorMessage: registerForm.password.isPure
                  ? null
                  : registerForm.password.errorMessage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
              label: 'Repite la contraseña',
              keyboardType: TextInputType.name,
              obscureText: true,
              onChanged: ref
                  .read(registerFormProvider.notifier)
                  .onPasswordConfirmationChange,
              errorMessage: registerForm.passwordConfirmation.isPure
                  ? null
                  : registerForm.passwordConfirmation.errorMessage,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tu contraseña debe tener',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Komet',
                  fontSize: 14,
                  height: 1.2,
                  color: Color(0xFFFFAA022),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  registerState.hasUpperCase ? Icons.check : Icons.close,
                  color: registerState.hasUpperCase
                      ? Color(0xFFFFAA022)
                      : Colors.red,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Al menos una letra mayúscula',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Komet',
                    fontSize: 14,
                    height: 1.2,
                    color: Color(0xFF0F2435),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  registerState.hasMinLength ? Icons.check : Icons.close,
                  color: registerState.hasMinLength
                      ? Color(0xFFFFAA022)
                      : Colors.red,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Un mínimo de 8 caracteres',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Komet',
                    fontSize: 14,
                    height: 1.2,
                    color: Color(0xFF0F2435),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  registerState.hasSpecialCharOrNumber
                      ? Icons.check
                      : Icons.close,
                  color: registerState.hasSpecialCharOrNumber
                      ? Color(0xFFFFAA022)
                      : Colors.red,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Debe tener un caracter especial o un número',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Komet',
                    fontSize: 14,
                    height: 1.2,
                    color: Color(0xFF0F2435),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFFAA02),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: registerForm.isValid
                    ? () =>
                        ref.read(registerFormProvider.notifier).onFormSubmit()
                    : null,
                child: registerForm.formStatus == FormStatus.validating
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Continuar',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _ThirdForm extends ConsumerWidget {
  final VoidCallback onContinue;
  const _ThirdForm({required this.onContinue});

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      } else {
        onContinue();
      }
    });
    final registerForm = ref.watch(registerFormProvider);
    final otpForm = ref.watch(otpFormProvider);
    return FadeInRight(
      duration: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
            'CÓDIGO DE VERIFICACIÓN ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'StenbergITC',
              fontSize: 28,
              height: 1.2,
              color: Color(0XFFEC1424),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Te enviamos un código al celular, una vez lo recibas ingrésalo aquí.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Komet',
              fontSize: 14,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            '${registerForm.phone.value.substring(0, 3)}***${registerForm.phone.value.substring(6, 10)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Komet',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          OtpInputField(
              length: 6, // Puedes cambiar a 4 si deseas menos inputs
              onCompleted: ref.read(otpFormProvider.notifier).onOtpChanged,
              errorMessage:
                  otpForm.otp.isPure ? null : otpForm.otp.errorMessage),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFFAA02),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: otpForm.isValid
                  ? ref.read(otpFormProvider.notifier).onFormSubmit
                  : null,
              child: const Text('Continuar'),
            ),
          )
        ],
      ),
    );
  }
}

class _FourForm extends ConsumerWidget {
  const _FourForm();

  

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tagForm = ref.watch(tagFormProvider);
    return FadeInRight(
      duration: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
            'YA NOS FALTA POQUITO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'StenbergITC',
              fontSize: 28,
              height: 1.2,
              color: Color(0XFFEC1424),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '¿Te identificas con alguno de estos roles?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Komet',
              fontSize: 14,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          SelectableCardList(
            items: [
              {"text": "tendero", "imagePath": "assets/Images/tendero.png"},
              {"text": "mesero", "imagePath": "assets/Images/mesero.png"},
              {"text": "nada", "imagePath": "assets/Images/ninguno.png"},
            ],
            onItemSelected: (selected) {
              ref.read(tagFormProvider.notifier).onTagChanged(selected);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFFAA02),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: tagForm.isValid
                  ? ref.read(tagFormProvider.notifier).onFormSubmit
                  : null,
              child: const Text('Continuar'),
            ),
          )
        ],
      ),
    );
  }
}
