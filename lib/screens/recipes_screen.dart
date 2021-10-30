import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';
import '../models/models.dart';

class RecipesScreen extends StatelessWidget {
  RecipesScreen({Key? key}) : super(key: key);

  final _mockFoodlerlichService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimpleRecipe>>(
      future: _mockFoodlerlichService.getRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data ?? [];
          return RecipesGridView(recipes: recipes);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
