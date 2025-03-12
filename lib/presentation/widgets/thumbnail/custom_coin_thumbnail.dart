import 'package:flutter/material.dart';

class CustomCoinThumbnail extends StatelessWidget {
  final String totalPoints;
  const CustomCoinThumbnail({
    super.key,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 253, 246, 240),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(width: 25), 
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  totalPoints,
                  style: TextStyle(
                    fontFamily: 'StenbergITC',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Imagen que sobresale del Container
        Positioned(
          left: -10, // Ajusta este valor para sobresalir más o menos
          top: -5,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/Images/icon_gozalapp.png',
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
