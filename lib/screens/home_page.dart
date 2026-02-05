import 'package:flutter/material.dart';
import '../widgets/premium_bottom_nav.dart';
import 'ordinary_drink_page.dart';
import 'cocktail_page.dart';
import 'shake_page.dart';
import 'favorite_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset('assets/images/home.jpg', fit: BoxFit.cover),
            ),

            // DARK OVERLAY
            Container(color: Colors.black.withOpacity(0.6)),

            // CONTENT
            _buildPage(),
          ],
        ),
      ),
      bottomNavigationBar: PremiumBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  Widget _buildPage() {
    switch (_currentIndex) {
      case 0:
        return _homeScreen();
      case 1:
        return const CocktailPage();
      case 2:
        return const FavoritePage();
      default:
        return _homeScreen();
    }
  }

  // ================= HOME =================
  Widget _homeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar("Home"),
          const SizedBox(height: 28),
          _menuCard("Ordinary Drink", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrdinaryDrinkPage()),
            );
          }),
          const SizedBox(height: 14),
          _menuCard("Cocktail", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CocktailPage()),
            );
          }),
          const SizedBox(height: 14),
          _menuCard("Shake", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ShakePage()),
            );
          }),
        ],
      ),
    );
  }

  // ================= TOP BAR =================
  Widget _topBar(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 24),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchPage()),
            );
          },
        ),
      ],
    );
  }

  // ================= MENU CARD =================
  Widget _menuCard(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                title,
                style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.chevron_right, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
