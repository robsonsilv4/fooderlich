import 'package:flutter/material.dart';
import 'package:fooderlich/components/author_card.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';

class CardTwo extends StatelessWidget {
  const CardTwo({required this.recipe, super.key});

  final ExploreRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
        child: Theme(
          data: ThemeData.dark(),
          child: Column(
            children: [
              AuthorCard(
                authorName: recipe.authorName,
                title: recipe.role,
                imageProvider: recipe.profileImage.isEmpty
                    ? null
                    : AssetImage(recipe.profileImage),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Text(
                        recipe.title,
                        style: FooderlichTheme.darkTextTheme.displaySmall,
                      ),
                    ),
                    Positioned(
                      bottom: 70,
                      left: 16,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          recipe.subtitle,
                          style: FooderlichTheme.darkTextTheme.displaySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
