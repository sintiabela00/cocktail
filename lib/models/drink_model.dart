class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, required this.measure});
}

class Drink {
  final String id;
  final String name;
  final String thumb;
  final String category;
  final String glass;
  final List<Ingredient> ingredients;

  final String instructions;

  Drink({
    required this.id,
    required this.name,
    required this.thumb,
    required this.category,
    required this.glass,
    required this.ingredients,
    required this.instructions,
  });
  factory Drink.fromJson(Map<String, dynamic> json) {
    final List<Ingredient> ingredients = [];

    for (int i = 1; i <= 15; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().isNotEmpty) {
        ingredients.add(Ingredient(name: ingredient, measure: measure ?? ''));
      }
    }

    return Drink(
      id: json['idDrink'] ?? '',
      name: json['strDrink'] ?? '',
      thumb: json['strDrinkThumb'] ?? '',
      category: json['strCategory'] ?? '',
      glass: json['strGlass'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
    );
  }
}
