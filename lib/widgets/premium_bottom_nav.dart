import 'package:flutter/material.dart';

class PremiumBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const PremiumBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFD4AF37);
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / 3;

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Stack(
        children: [
          // Garis indikator presisi tepat di tengah icon
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 0,
            left: (itemWidth * currentIndex) + (itemWidth / 2) - 20,
            child: Container(
              width: 40,
              height: 3,
              color: gold,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                _item(Icons.home, "Home", 0),
                _item(Icons.local_bar, "Drinks", 1),
                _item(Icons.favorite, "Favorite", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String label, int index) {
    const gold = Color(0xFFD4AF37);
    final active = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? gold : Colors.white54, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active ? gold : Colors.white54,
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
