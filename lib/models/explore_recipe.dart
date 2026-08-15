part 'ingredient.dart';
part 'instruction.dart';

class RecipeCardType {
  static const card1 = 'card1';
  static const card2 = 'card2';
  static const card3 = 'card3';
}

class ExploreRecipe {
  ExploreRecipe({
    required this.id,
    required this.cardType,
    required this.title,
    this.subtitle = '',
    this.backgroundImage = '',
    this.backgroundImageSource = '',
    this.message = '',
    this.authorName = '',
    this.role = '',
    this.profileImage = '',
    this.durationInMinutes = 0,
    this.dietType = '',
    this.calories = 0,
    this.tags = const [],
    this.description = '',
    this.source = '',
    this.ingredients = const [],
    this.instructions = const [],
  });

  factory ExploreRecipe.fromJson(Map<String, dynamic> json) {
    final ingredients = <Ingredients>[];
    final instructions = <Instruction>[];

    final jsonIngredients = json['ingredients'] as List<dynamic>?;
    if (jsonIngredients != null) {
      for (final value in jsonIngredients) {
        ingredients.add(
          Ingredients.fromJson(value as Map<String, dynamic>),
        );
      }
    }

    final jsonInstructions = json['instructions'] as List<dynamic>?;
    if (jsonInstructions != null) {
      for (final value in jsonInstructions) {
        instructions.add(
          Instruction.fromJson(value as Map<String, dynamic>),
        );
      }
    }

    return ExploreRecipe(
      id: json['id'] as String? ?? '',
      cardType: json['cardType'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      backgroundImage: json['backgroundImage'] as String? ?? '',
      backgroundImageSource: json['backgroundImageSource'] as String? ?? '',
      message: json['message'] as String? ?? '',
      authorName: json['authorName'] as String? ?? '',
      role: json['role'] as String? ?? '',
      profileImage: json['authorImage'] as String? ?? '',
      durationInMinutes: json['durationInMinutes'] as int? ?? 0,
      dietType: json['dietType'] as String? ?? '',
      calories: json['calories'] as int? ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      description: json['description'] as String? ?? '',
      source: json['source'] as String? ?? '',
      ingredients: ingredients,
      instructions: instructions,
    );
  }
  String id;
  String cardType;
  String title;
  String subtitle;
  String backgroundImage;
  String backgroundImageSource;
  String message;
  String authorName;
  String role;
  String profileImage;
  int durationInMinutes;
  String dietType;
  int calories;
  List<String> tags;
  String description;
  String source;
  List<Ingredients> ingredients;
  List<Instruction> instructions;
}
