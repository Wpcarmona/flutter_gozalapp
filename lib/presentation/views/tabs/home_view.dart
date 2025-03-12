import 'package:flutter/material.dart';
import 'package:gozalapp/presentation/widgets/widgets.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String imageSrc;
  final Color color;

  MenuItem({
    required this.title, 
    required this.subtitle, 
    required this.imageSrc,
    required this.color
    });
  
}

final menuItems = <MenuItem>[
  MenuItem(title: '¿PA’ DÓNDE', subtitle: 'VAMOS?', color: Colors.red, imageSrc: 'assets/Images/calendar.png'),
  MenuItem(title: 'SÚBELE EL', subtitle: 'VOLUMEN', color: Color(0xFF07A0DE), imageSrc: 'assets/Images/radio.png'),
  MenuItem(title: 'LA REAL', subtitle: 'ACADEMIA', color: Color(0xFF089444), imageSrc: 'assets/Images/focus_paper.png'),
  MenuItem(title: 'DÉJAME', subtitle: "VE'A’ VE", color: Color(0xFFEB77AF), imageSrc: 'assets/Images/tablet_touch.png'),

];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '¡TIENES QUE VER ESTO SÍ O SÍ!',
              style: TextStyle(
                fontFamily: 'StenbergITC',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                height: 14 / 16,
                color: Color(0xFFec1424),
              ),
            ),
            FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xFFFFAA02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Ver todos',
                  style: TextStyle(
                      fontFamily: 'Komet',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900),
                ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomChallengeCard(
            totalPoint: '1000',
            text:
                'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            image:
                'https://cdnx.jumpseller.com/cash247/image/50679638/resize/1200/1200?1720965543'),
        const SizedBox(
          height: 40,
        ),
        const Text(
          '¡PA’ QUE TE LO GOCES!',
          style: TextStyle(
            fontFamily: 'StenbergITC',
            fontWeight: FontWeight.normal,
            fontSize: 18,
            height: 14 / 16,
            color: Color(0xFFec1424),
          ),
        ),
        const SizedBox(
          height: 40,
        ),

        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
          children: menuItems.map((item) => CustomSelectableCard(
            imagePath: item.imageSrc, 
            title: item.title, 
            subtitle: item.subtitle, 
            color: item.color, 
            onTap: (){})).toList(),
          ),
        const SizedBox(height: 20),
        
      ],
    ));
  }
}
