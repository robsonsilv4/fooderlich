import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/card_one.dart';
import 'package:fooderlich/components/card_three.dart';
import 'package:fooderlich/components/card_two.dart';
import 'package:fooderlich/components/today_recipe_list_view.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(TodayRecipeListView, () {
    testWidgets(
      'renders the header',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildExploreRecipe();

        await tester.pumpApp(
          TodayRecipeListView(recipes: [recipe]),
        );

        expect(find.text('Recipes of the Day 🍳'), findsOneWidget);
      },
    );

    testWidgets(
      'builds a $CardOne for card1 recipes',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildExploreRecipe();

        await tester.pumpApp(
          TodayRecipeListView(recipes: [recipe]),
        );

        expect(find.byType(CardOne), findsOneWidget);
      },
    );

    testWidgets(
      'builds a $CardTwo for card2 recipes',
      tags: [TestTag.widget],
      (tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        final recipe = buildExploreRecipe(
          cardType: RecipeCardType.card2,
          authorName: 'Ray',
          role: 'Founder',
        );

        await tester.pumpApp(
          TodayRecipeListView(recipes: [recipe]),
        );

        expect(find.byType(CardTwo), findsOneWidget);
      },
    );

    testWidgets(
      'builds a $CardThree for card3 recipes',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildExploreRecipe(cardType: RecipeCardType.card3);

        await tester.pumpApp(
          TodayRecipeListView(recipes: [recipe]),
        );

        expect(find.byType(CardThree), findsOneWidget);
      },
    );

    testWidgets(
      'throws for an unknown card type',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildExploreRecipe(cardType: 'unknown');

        await tester.pumpApp(
          TodayRecipeListView(recipes: [recipe]),
        );

        expect(tester.takeException(), isA<Exception>());
      },
    );
  });
}
