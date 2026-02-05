import 'package:flutter/material.dart';
import '../models/drink_model.dart';
import '../services/cocktail_api_service.dart';
import '../services/favorite_service.dart';

class DrinkDetailPage extends StatefulWidget {
  final String drinkId;
  const DrinkDetailPage({super.key, required this.drinkId});

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  Drink? drink;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final d = await CocktailApiService.fetchDetail(widget.drinkId);
    setState(() => drink = d);
  }

  @override
  Widget build(BuildContext context) {
    final isFav = drink != null && FavoriteService.isFavorite(drink!.id);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xFFD4AF37),
            ),
            onPressed: () {
              if (drink != null) {
                setState(() {
                  FavoriteService.toggle(drink!);
                });
              }
            },
          ),
        ],
      ),
      body: drink == null
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: const Color(0xFF2A2A2A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.network(
                          drink!.thumb,
                          width: 220,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        drink!.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 10),

                      _infoRow("Category", drink!.category),
                      _infoRow("Glass", drink!.glass),

                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 12),

                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Column(
                        children: drink!.ingredients.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  item.measure,
                                  style: const TextStyle(
                                    color: Color(0xFFD4AF37),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 12),

                      Text(
                        drink!.instructions,
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
