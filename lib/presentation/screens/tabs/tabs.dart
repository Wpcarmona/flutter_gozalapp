import 'package:flutter/material.dart';
import 'package:gozalapp/presentation/views/views.dart';
import 'package:gozalapp/presentation/widgets/header/header_widget.dart';

class TabsScreen extends StatefulWidget {
  static const name = 'tabs-screen';
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentTab = 0;
  final List<Widget> screens = const [
    HomeView(),
    LukasView(),
    MapsView(),
    ShoppingView(),
    VacilonView()
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 4;
            currentScreen = const LukasView();
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
                  currentScreen = const HomeView();
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
                  currentScreen = const VacilonView();
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
                  currentScreen = const ShoppingView();
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
                  currentScreen = const MapsView();
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

