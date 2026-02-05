import 'package:flutter/material.dart';
import '../services/cocktail_api_service.dart';
import '../models/drink_model.dart';
import 'drink_detail_page.dart';

class OrdinaryDrinkPage extends StatefulWidget {
  const OrdinaryDrinkPage({super.key});

  @override
  State<OrdinaryDrinkPage> createState() => _OrdinaryDrinkPageState();
}

class _OrdinaryDrinkPageState extends State<OrdinaryDrinkPage> {
  List<Drink> drinks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final data =
        await CocktailApiService.fetchByCategory("Ordinary_Drink");
    setState(() {
      drinks = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Ordinary Drink",
            style: TextStyle(color: Color(0xFFD4AF37))),
        backgroundColor: Colors.black,
      ),
      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(color: Color(0xFFD4AF37)))
          : ListView.builder(
              itemCount: drinks.length,
              itemBuilder: (c, i) {
                final d = drinks[i];
                return ListTile(
                  leading: Image.network(d.thumb, width: 45),
                  title: Text(d.name,
                      style: const TextStyle(
                          color: Color(0xFFD4AF37))),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DrinkDetailPage(drinkId: d.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
