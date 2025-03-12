import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gozalapp/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HeaderWidget extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HeaderWidget({super.key, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  HeaderWidgetState createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget> {
  String userName = '';
  String avatar = '';
  String totalPoints = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userInfo');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      String image = userMap['avatar'] ?? '';
      String fullName = userMap['nombre_completo'] ?? 'Usuario';
      int totalPoint = userMap['total_points'] ?? 0;

      setState(() {
        userName = fullName.split(' ').first;
        avatar = image;
        totalPoints = totalPoint.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFC942),
      title: ThumbnailWidget(imageUrl: avatar, name: userName),
      leading: IconButton(
        onPressed: () {
          widget.scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.menu_rounded , color: Colors.white,size: 40,),
      ),
      actions: <Widget>[
        GestureDetector(
          child: CustomCoinThumbnail(totalPoints: totalPoints,),
          onTap: () => context.push('/notifications')
          ),
        IconButton(
          icon: const Icon(Icons.add_alert),
          onPressed: () {
            context.push('/notifications');
          },
        ),
      ],
    );
  }
}
