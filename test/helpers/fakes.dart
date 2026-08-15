import 'package:flutter/painting.dart';
import 'package:fooderlich/models/models.dart';

ExploreRecipe buildExploreRecipe({
  String cardType = RecipeCardType.card1,
}) {
  return ExploreRecipe(
    id: '1',
    cardType: cardType,
    title: 'The Art of Dough',
    subtitle: "Editor's Choice",
    backgroundImage: 'assets/magazine_pics/card_bread.jpg',
    message: 'Learn to make the perfect bread.',
    authorName: 'Ray Wenderlich',
    role: 'Founder of Raywenderlich',
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

GroceryItem buildGroceryItem({Importance importance = Importance.medium}) {
  return GroceryItem(
    id: '1',
    name: 'Milk',
    importance: importance,
    color: const Color(0xFF42A5F5),
    quantity: 2,
    date: DateTime(2026, 1, 15),
  );
}
