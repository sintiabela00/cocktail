import 'package:flutter/material.dart';
import '../main.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(title: 'Cocktail Lounge'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // BACKGROUND FULL SCREEN FIX
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset('assets/images/splash_bg.jpeg'),
              ),
            ),

            // Overlay gelap
            Container(color: Colors.black.withOpacity(0.35)),

            // Konten bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.local_bar, color: Color(0xFFD4AF37), size: 28),
                    SizedBox(height: 6),
                    Text(
                      'COCKTAIL LOUNGE',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 18,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
