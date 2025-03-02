import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gozalapp/presentation/providers/providers.dart';
import 'package:gozalapp/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginPage();
  }
}

class _LoginPage extends ConsumerWidget {
  const _LoginPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xFFFFC942),
              image: DecorationImage(
                image: AssetImage('assets/Images/headerlogo.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height - 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/Images/background_barranquilla.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFFFBE9DC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: _FormContent(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormContent extends ConsumerWidget {
  const _FormContent();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        Text(
          'BIENVENIDO, ¡CARNAVALERO, CURRAMBERO, RECOCHERO!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'StenbergITC',
            fontSize: 24,
            height: 0.9,
            color: Color(0XFFEC1424),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            label: 'Numero de documento',
            onChanged:
                ref.read(loginFormProvider.notifier).onNumerDocumentChanged,
            errorMessage: loginForm.numberDocument.isPure
                ? null
                : loginForm.numberDocument.errorMessage,
            keyboardType: TextInputType.phone,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage: loginForm.password.isPure
                ? null
                : loginForm.password.errorMessage,
            keyboardType: TextInputType.text,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {
                context.go('/auth/reset-password');
              },
              child: const Text(
                'Olvidé mi contraseña',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFFFFAA02)),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Color(0xFFFFAA02), // Color del botón
              padding:
                  const EdgeInsets.symmetric(vertical: 15), // Padding vertical
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
              ),
            ),
            onPressed: loginForm.isValid
                ? () => ref.read(loginFormProvider.notifier).onFormSubmit()
                : null,
            child: loginForm.formStatus == FormStatus.validating
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Color(0xFFFFF5ED),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.fingerprint,
                  color: Color(0xFFFFAA02),
                  size: 24,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Usar Biometria',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFAA02)),
                ),
              ],
            ),
          ),
        ),
        _RegisterButton()
      ],
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Positioned(
        bottom: 30,
        left: 20, // Margen izquierdo
        right: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿No tienes cuenta?',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFFB49480)),
            ),
            TextButton(
              onPressed: () {
                context.go('/auth/register');
              },
              child: const Text(
                'Registrate',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFFFFAA02),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
