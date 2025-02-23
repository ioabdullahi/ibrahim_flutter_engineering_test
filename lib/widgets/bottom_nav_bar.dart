import 'package:flutter/material.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/image_constants.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      );
    });
  }

  void _onTap(int index) {
    setState(() {
      widget.onItemTapped(index);
    });
    _animationController.forward().then((_) => _animationController.reverse());

    // Calls the callback to update selected index (if needed)
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(assetPath: ImageConstants.searchIcon, index: 0),
          _navItem(assetPath: ImageConstants.chatIcon, index: 1),
          _navItem(
              assetPath: ImageConstants.homeIcon, index: 2, isCenter: true),
          _navItem(assetPath: ImageConstants.favoriteIcon, index: 3),
          _navItem(assetPath: ImageConstants.userIcon, index: 4),
        ],
      ),
    );
  }

  Widget _navItem({
    required String assetPath,
    required int index,
    bool isCenter = false,
  }) {
    bool isSelected = widget.selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTap(index),
      child: ScaleTransition(
        scale:
            isSelected ? _scaleAnimations[index] : AlwaysStoppedAnimation(1.0),
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: 15,
                    ),
                  ],
                )
              : null,
          padding: const EdgeInsets.all(12),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : Colors.white,
              BlendMode.srcIn,
            ),
            child: Image.asset(
              assetPath,
              width: isCenter ? 36 : 28,
              height: isCenter ? 36 : 28,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
