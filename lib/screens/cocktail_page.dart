import 'package:flutter/material.dart';
import '../services/cocktail_api_service.dart';
import '../models/drink_model.dart';
import 'drink_detail_page.dart';

class CocktailPage extends StatefulWidget {
  const CocktailPage({super.key});

  @override
  State<CocktailPage> createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  List<Drink> drinks = [];
  List<Drink> filtered = [];
  bool loading = true;
  bool searching = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final data = await CocktailApiService.fetchByCategory("Cocktail");
    setState(() {
      drinks = data;
      filtered = data;
      loading = false;
    });
  }

  void _onSearch(String text) {
    setState(() {
      filtered = drinks
          .where((d) => d.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: searching
            ? TextField(
                autofocus: true,
                onChanged: _onSearch,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Search drink...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              )
            : const Text("Drinks", style: TextStyle(color: Color(0xFFD4AF37))),
        actions: [
          IconButton(
            icon: Icon(
              searching ? Icons.close : Icons.search,
              color: const Color(0xFFD4AF37),
            ),
            onPressed: () {
              setState(() {
                searching = !searching;
                filtered = drinks;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset('assets/images/home.jpg', fit: BoxFit.cover),
          ),

          // DARK OVERLAY
          Container(color: Colors.black.withOpacity(0.6)),

          // CONTENT
          SafeArea(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
                  )
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (c, i) {
                      final d = filtered[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DrinkDetailPage(drinkId: d.id),
                              ),
                            );
                          },
                          child: Container(
                            height: 72,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    d.thumb,
                                    width: 52,
                                    height: 52,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    d.name,
                                    style: const TextStyle(
                                      color: Color(0xFFD4AF37),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white70,
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
