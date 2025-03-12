import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gozalapp/presentation/providers/auth/auth_provider.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final colors = Theme.of(context).colorScheme;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Encabezado opcional del menú
            Padding(
              padding: EdgeInsets.fromLTRB(28, hasNotch ? 40 : 20, 16, 10),
              child: const Text(
                'Menú',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Opciones del menú
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Inicio'),
                    onTap: () {
                      context.go('/');
                      widget.scaffoldKey.currentState?.closeDrawer();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Perfil'),
                    onTap: () {
                      context.go('/profile');
                      widget.scaffoldKey.currentState?.closeDrawer();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configuración'),
                    onTap: () {
                      setState(() => navDrawerIndex = 1);
                      widget.scaffoldKey.currentState?.closeDrawer();
                    },
                  ),
                ],
              ),
            ),

            // Botón de cerrar sesión
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton.icon(
                  onPressed: () {
                    ref.read(authProvider.notifier).logout();
                    widget.scaffoldKey.currentState?.closeDrawer();
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFFFFAA02)),
                  label: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                      color: Color(0xFFFFAA02),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.transparent, // Fondo transparente
                    foregroundColor: Colors.white, // Color del texto y el ícono
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
