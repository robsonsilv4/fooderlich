import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/screens/recipes_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(RecipesScreen, () {
    testWidgets(
      'shows a progress indicator while loading',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(RecipesScreen());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 100));
      },
    );

    testWidgets(
      'renders the recipe grid once data is loaded',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(RecipesScreen());
        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );
  });
}
