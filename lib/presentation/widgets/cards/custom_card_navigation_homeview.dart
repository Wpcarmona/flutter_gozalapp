import 'package:flutter/material.dart';

class CustomSelectableCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const CustomSelectableCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Card Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),// Espacio para la imagen
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 70), 
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'StenbergITC',
                        fontWeight: FontWeight.normal,
                        fontSize: 22,
                        height: 14 / 16,
                        color: Colors.white),
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'StenbergITC',
                        fontWeight: FontWeight.normal,
                        fontSize: 22,
                        height: 14 / 16,
                        color: Colors.white),
                    ),
                  ],
                ),
              ),
              // Imagen centrada que sobresale
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
