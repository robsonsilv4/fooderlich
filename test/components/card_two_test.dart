import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/card_two.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(CardTwo, () {
    testWidgets(
      'renders author name and recipe title',
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

        await tester.pumpApp(CardTwo(recipe: recipe));

        expect(find.text(recipe.authorName), findsOneWidget);
        expect(find.text(recipe.role), findsOneWidget);
        expect(find.text(recipe.title), findsOneWidget);
      },
    );
  });
}
