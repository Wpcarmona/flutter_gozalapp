import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  String userName = 'Usuario';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      String fullName = userMap['name'] ?? 'Usuario';
      
      // Tomar solo la primera palabra del nombre
      setState(() {
        userName = fullName.split(' ').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Hola, $userName'),
      leading: IconButton(
        onPressed: () {
          widget.scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
      actions: <Widget>[
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
