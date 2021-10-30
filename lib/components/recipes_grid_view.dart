import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  final List<SimpleRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: double.maxFinite,
        ),
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeThumbnail(recipe: recipe);
        },
      ),
    );
  }
}
