import '../models/drink_model.dart';

class FavoriteService {
  static final List<Drink> _favorites = [];

  static List<Drink> get favorites => _favorites;

  static bool isFavorite(String id) {
    return _favorites.any((d) => d.id == id);
  }

  static void toggle(Drink drink) {
    if (isFavorite(drink.id)) {
      _favorites.removeWhere((d) => d.id == drink.id);
    } else {
      _favorites.add(drink);
    }
  }
}
