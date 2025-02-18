import 'package:flutter/material.dart';
import 'package:gozalapp/presentation/widgets/inputs/custom_list_input.dart';
import 'package:gozalapp/presentation/widgets/inputs/custom_text_form_field.dart';

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

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final PageController pageViewController = PageController();
  bool enReached = false;

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;
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
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: 16,
          right: 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: 0.25,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFC942)),
              ),
            ),
          ),
        ),
        // Positioned(
        //   top: 98,
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 20),
        //     child: SingleChildScrollView(
        //       child: const _FirstForm(),
        //     ),
        //   ),
        // ),
        Positioned(
          top: 98,
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: _SecondForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondForm extends StatelessWidget {
  const _SecondForm();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            label: 'Repite la contraseña',
            keyboardType: TextInputType.name,
            obscureText: true,
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
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.check, 
              color: Color(0xFFFFAA022), 
              size: 20),
              SizedBox(width: 10,),
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.check, 
              color: Color(0xFFFFAA022), 
              size: 20),
              SizedBox(width: 10,),
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.close, 
              color: Color(0xFFD3B19B), 
              size: 20),
              SizedBox(width: 10,),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: const Text(
                'Continuar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _FirstForm extends StatefulWidget {
  const _FirstForm();

  @override
  State<_FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<_FirstForm> {
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;
  bool isReferrals = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            label: 'Número de documento',
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            label: 'Teléfono',
            keyboardType: TextInputType.phone,
          ),
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
                  items: List.generate(31, (index) => index + 1),
                  onChanged: (value) {
                    setState(() {
                      selectedDay = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInputList(
                  label: "Mes",
                  selectedValue: selectedMonth,
                  items: List.generate(12, (index) => index + 1),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInputList(
                  label: "Año",
                  selectedValue: selectedYear,
                  items: List.generate(2007 - 1900 + 1, (index) => 1900 + index).reversed.toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFFAA02),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: const Text(
                'Continuar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
