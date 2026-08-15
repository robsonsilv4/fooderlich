import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/card_three.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(CardThree, () {
    testWidgets(
      'renders recipe title and tag chips',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildExploreRecipe();

        await tester.pumpApp(CardThree(recipe: recipe));

        expect(find.text(recipe.title), findsOneWidget);
        for (final tag in recipe.tags.take(6)) {
          expect(find.text(tag), findsOneWidget);
        }
      },
    );

    testWidgets(
      'renders at most six tags',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildExploreRecipe();
        final manyTags = ExploreRecipe(
          id: recipe.id,
          cardType: recipe.cardType,
          title: recipe.title,
          backgroundImage: 'assets/magazine_pics/card_bread.jpg',
          tags: List.generate(8, (index) => 'tag$index'),
        );

        await tester.pumpApp(CardThree(recipe: manyTags));

        expect(find.byType(Chip), findsNWidgets(6));
      },
    );
  });
}
