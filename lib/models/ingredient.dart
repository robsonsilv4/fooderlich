part of 'explore_recipe.dart';

class Ingredients {
  Ingredients({
    required this.imageUrl,
    required this.title,
    required this.source,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      imageUrl: json['imageUrl'] as String? ?? '',
      title: json['title'] as String? ?? '',
      source: json['source'] as String? ?? '',
    );
  }
  String imageUrl;
  String title;
  String source;
}
