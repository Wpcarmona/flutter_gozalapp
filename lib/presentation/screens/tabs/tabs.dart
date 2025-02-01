import 'package:flutter/material.dart';
import 'package:gozalapp/presentation/screens/tabs/home/home_screen.dart';
import 'package:gozalapp/presentation/screens/tabs/lukas/lukas_screen.dart';
import 'package:gozalapp/presentation/screens/tabs/maps/maps_screen.dart';
import 'package:gozalapp/presentation/screens/tabs/shopping/shopping_screen.dart';
import 'package:gozalapp/presentation/screens/tabs/vacilon/vacilon_screen.dart';

class TabsScreen extends StatefulWidget {
  static const name = 'tabs-screen';
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentTab = 0;
  final List<Widget> screens = const [
    HomeScreen(),
    VacilonScreen(),
    ShoppingScreen(),
    MapsScreen(),
    LukasScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 4;
            currentScreen = const LukasScreen();
          });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: const Color(0xFFFFC942),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildBottomBarItem(
              icon: Icons.home_outlined,
              label: 'Inicio',
              index: 0,
              onTap: () {
                setState(() {
                  currentTab = 0;
                  currentScreen = const HomeScreen();
                });
              },
            ),
            _buildBottomBarItem(
              icon: Icons.person,
              label: 'Vacilón',
              index: 1,
              onTap: () {
                setState(() {
                  currentTab = 1;
                  currentScreen = const VacilonScreen();
                });
              },
            ),
            const SizedBox(width: 40), // Espacio para el FAB
            _buildBottomBarItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Compras',
              index: 2,
              onTap: () {
                setState(() {
                  currentTab = 2;
                  currentScreen = const ShoppingScreen();
                });
              },
            ),
            _buildBottomBarItem(
              icon: Icons.map_outlined,
              label: 'Mapa',
              index: 3,
              onTap: () {
                setState(() {
                  currentTab = 3;
                  currentScreen = const MapsScreen();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Construye un botón con ícono y texto apilados.
  Widget _buildBottomBarItem({
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentTab == index ? Colors.black : Colors.white,
          ),
          const SizedBox(height: 4), // Espacio entre ícono y texto
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: currentTab == index ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
