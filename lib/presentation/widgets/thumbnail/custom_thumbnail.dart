import 'package:flutter/material.dart';

class ThumbnailWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool isLocalImage;

  const ThumbnailWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.isLocalImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Imagen Circular
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: isLocalImage 
              ? Image.asset(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 40),
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hola',
                style: TextStyle(
                  fontFamily: 'Komet',
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  height: 14 / 12,
                  color: Color(0xFFE40311),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name.toUpperCase(),
                style: const TextStyle(
                   fontFamily: 'StenbergITC',
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    height: 14 / 16,  
                    color: Color(0xFF112333),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
