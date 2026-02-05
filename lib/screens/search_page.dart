import 'package:flutter/material.dart';
import '../services/cocktail_api_service.dart';
import '../models/drink_model.dart';
import 'drink_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Drink> results = [];
  bool loading = false;

  void _search(String text) async {
    if (text.isEmpty) {
      setState(() => results = []);
      return;
    }

    setState(() => loading = true);
    final data = await CocktailApiService.search(text);
    setState(() {
      results = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          autofocus: true,
          onChanged: _search,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search cocktail...",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (c, i) {
                final d = results[i];
                return ListTile(
                  leading: Image.network(d.thumb, width: 45),
                  title: Text(d.name,
                      style:
                          const TextStyle(color: Color(0xFFD4AF37))),
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
