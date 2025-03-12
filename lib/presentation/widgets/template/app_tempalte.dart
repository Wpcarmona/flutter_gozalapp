import 'package:flutter/material.dart';

class AppTemplate extends StatelessWidget {
  final Widget body;
  final Color backgroundColor;

  const AppTemplate({
    super.key,
    required this.body,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color(0xFFFFC942),
              image: DecorationImage(
                image: AssetImage('assets/Images/headerlogo.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Contenedor desplazable
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
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
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: body,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
