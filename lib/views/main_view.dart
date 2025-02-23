import 'package:flutter/material.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/widgets/bottom_nav_bar.dart';
import 'home_view.dart';
import 'map_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late Animation<Offset> _slideInBottomNav;
  late AnimationController _bottomNavController;

  int _selectedIndex = 2;

  // List of screens
  final List<Widget> _pages = [
    MapView(), // Map View
    Scaffold(), // Chat Screen
    HomeView(), // Home Screen
    Scaffold(), // Favorite Screen
    Scaffold(), // Profile Screen
  ];
  @override
  void initState() {
    super.initState();
    _bottomNavController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _slideInBottomNav = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _bottomNavController, curve: Curves.easeInOut));
    _bottomNavController.forward();
  }

  // Updates selected index when a nav item is clicked
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _slideInBottomNav,
              child: Container(
                color: Colors.transparent,
                child: BottomNavBar(
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
