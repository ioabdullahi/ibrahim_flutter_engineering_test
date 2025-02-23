import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/app_colors.dart';

class CategoryButton extends StatefulWidget {
  final String title;
  final int count;
  final bool isSelected;
  final bool isCircular;
  final VoidCallback onPressed;

  const CategoryButton({
    Key? key,
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onPressed,
    this.isCircular = false,
  }) : super(key: key);

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animatedCount;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Smooth 2-second animation
    );

    _animatedCount = IntTween(begin: 0, end: widget.count).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(CategoryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      _controller.dispose();
      _setupAnimation(); // Restarts animation with new count
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double buttonSize = widget.isCircular ? 100 : 100; // Bigger buttons
    final Color textColor = widget.isCircular
        ? AppColors.white
        : AppColors.primaryLight; // Different text colors

    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        shape: widget.isCircular
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.all(widget.isCircular ? 30 : 20),
        backgroundColor:
            widget.isSelected ? AppColors.primary : AppColors.white,
      ),
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.dmSans(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _animatedCount,
              builder: (context, child) {
                // Formats number with spacing between first digit
                String countText = _formatNumber(_animatedCount.value);

                return Text(
                  countText,
                  style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: 28, // Bigger number
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3, // Extra spacing
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              "Offer",
              style: GoogleFonts.dmSans(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to format fnumber with spacing
  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (numberStr.length > 1) {
      return "${numberStr[0]} ${numberStr.substring(1)}";
    }
    return numberStr;
  }
}
