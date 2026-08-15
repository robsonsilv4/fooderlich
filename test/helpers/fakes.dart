import 'package:flutter/painting.dart';
import 'package:fooderlich/models/models.dart';

ExploreRecipe buildExploreRecipe({
  String cardType = RecipeCardType.card1,
  String authorName = 'Ray Wenderlich',
  String role = 'Founder of Raywenderlich',
}) {
  return ExploreRecipe(
    id: '1',
    cardType: cardType,
    title: 'The Art of Dough',
    subtitle: "Editor's Choice",
    backgroundImage: 'assets/magazine_pics/card_bread.jpg',
    message: 'Learn to make the perfect bread.',
    authorName: authorName,
    role: role,
    profileImage: 'assets/profile_pics/person_ray.jpeg',
    tags: const ['Carbs', 'Dough', 'Crunchy', 'Yummy'],
  );
}

SimpleRecipe buildSimpleRecipe() {
  return SimpleRecipe(
    id: '1',
    dishImage: 'assets/food_pics/food_flour.jpg',
    title: 'Pizza',
    duration: '30 min',
    source: 'Pixabay',
    information: const ['Italian'],
  );
}

Post buildPost() {
  return Post(
    id: '1',
    profileImageUrl: 'assets/profile_pics/person_ray.jpeg',
    comment: 'Great bread!',
    foodPictureUrl: 'assets/food_pics/food_flour.jpg',
    timestamp: '2h',
  );
}

GroceryItem buildGroceryItem({
  String id = '1',
  String name = 'Milk',
  Importance importance = Importance.medium,
  bool isComplete = false,
}) {
  return GroceryItem(
    id: id,
    name: name,
    importance: importance,
    color: const Color(0xFF42A5F5),
    quantity: 2,
    date: DateTime(2026, 1, 15),
    isComplete: isComplete,
  );
}
