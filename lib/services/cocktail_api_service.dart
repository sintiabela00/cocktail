import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/drink_model.dart';

class CocktailApiService {
  static const String baseUrl = "https://www.thecocktaildb.com/api/json/v1/1";

  // List by Category (Cocktail, Ordinary_Drink, Shake)
  static Future<List<Drink>> fetchByCategory(String category) async {
    final res = await http.get(Uri.parse("$baseUrl/filter.php?c=$category"));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return (data['drinks'] as List)
          .map(
            (e) => Drink(
              id: e['idDrink'],
              name: e['strDrink'],
              thumb: e['strDrinkThumb'],
              category: '',
              glass: '',
              ingredients: [],
              instructions: '',
            ),
          )
          .toList();
    } else {
      throw Exception("Failed load category");
    }
  }

  // Search by name
  static Future<List<Drink>> search(String keyword) async {
    final res = await http.get(Uri.parse("$baseUrl/search.php?s=$keyword"));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      if (data['drinks'] == null) return [];
      return (data['drinks'] as List).map((e) => Drink.fromJson(e)).toList();
    } else {
      throw Exception("Search error");
    }
  }

  // Detail
  static Future<Drink> fetchDetail(String id) async {
    final res = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return Drink.fromJson(data['drinks'][0]);
    } else {
      throw Exception("Detail error");
    }
  }
}
