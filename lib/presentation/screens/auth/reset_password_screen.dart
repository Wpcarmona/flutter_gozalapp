import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gozalapp/config/constants/countryCode.dart';
import 'package:gozalapp/presentation/providers/auth/register_form_provider.dart';
import 'package:gozalapp/presentation/widgets/inputs/custom_list_input.dart';
import 'package:gozalapp/presentation/widgets/inputs/custom_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const name = 'reset-password-screen';
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ResetPasswordView(),
    );
  }
}

class _ResetPasswordView extends ConsumerWidget {
  
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);
    String? selectedDocumentType;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/Images/background_barranquilla.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 60,
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
                    context.go('/auth/login');
                  },
                ),
              ),
            )),
        Positioned(
            top: 140,
            left: 16,
            right: 16,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'RECUPERAR CONTRASEñA',
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
                  'Ingresa el número con el que te registraste y te enviaremos un enlace para actualizar tu contraseña.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Komet',
                    fontSize: 14,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                 Row(
            children: [
              Expanded(
                flex: 4,
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
                          : registerForm.phone.errorMessage
                     ),
                ),
              ),
            ],
          ),
              ],
            )),
        Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFFAA02),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: (){},
                  child: const Text(
                    'Enviar mensaje',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya no cuentas con este número? ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFFB49480)),
                    ),
                    TextButton(
                      onPressed: () {
                       
                      },
                      child: const Text(
                        'Escríbenos',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFFFFAA02),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ))
      ],
    );
  }
}
