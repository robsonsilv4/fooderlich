import 'package:flutter/material.dart';

import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';

class CardOne extends StatelessWidget {
  const CardOne({
    required this.recipe, super.key,
  });

  final ExploreRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Text(
              recipe.subtitle,
              style: FooderlichTheme.darkTextTheme.bodyLarge,
            ),
            Positioned(
              top: 20,
              child: Text(
                recipe.title,
                style: FooderlichTheme.darkTextTheme.displayMedium,
              ),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              child: Text(
                recipe.message,
                style: FooderlichTheme.darkTextTheme.bodyLarge,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Text(
                recipe.authorName,
                style: FooderlichTheme.darkTextTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
