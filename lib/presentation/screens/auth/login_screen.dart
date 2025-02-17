import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gozalapp/infraestructure/inputs/numberDocument.dart';
import 'package:gozalapp/infraestructure/inputs/password.dart';
import 'package:gozalapp/presentation/cubit/login/login_cubit.dart';
import 'package:gozalapp/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LoginCubit(), child: _LoginPage());
  }
}

class _LoginPage extends StatelessWidget {
  const _LoginPage();
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();
    final userDocument = loginCubit.state.numberDocument;
    final passwoord = loginCubit.state.password;
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
                  image: AssetImage('assets/Images/background_barranquilla.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFFFBE9DC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: _FormContent(
                loginCubit: loginCubit, 
                userDocument: userDocument, 
                passwoord: passwoord),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormContent extends StatelessWidget {
  const _FormContent({
    required this.loginCubit,
    required this.userDocument,
    required this.passwoord,
  });

  final LoginCubit loginCubit;
  final NumberDocument userDocument;
  final Password passwoord;

  @override
  Widget build(BuildContext context) {
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
            onChanged: loginCubit.numberDocumentChanged,
            errorMessage: userDocument.errorMessage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: loginCubit.passwordChanged,
            errorMessage: passwoord.errorMessage,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {},
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
              padding: const EdgeInsets.symmetric(
                  vertical: 15), // Padding vertical
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // Bordes redondeados
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Ingresar',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
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
        SafeArea(
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
                        color: Color(0xFFB49480)
                      ),
                      ),
                    TextButton(
                      onPressed: () {
                        context.push('/auth/register');
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
        )
      ],
    );
  }
}
