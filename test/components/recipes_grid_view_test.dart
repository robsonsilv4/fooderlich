import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/recipe_thumbnail.dart';
import 'package:fooderlich/components/recipes_grid_view.dart';

import '../helpers/helpers.dart';

void main() {
  group(RecipeThumbnail, () {
    testWidgets(
      'renders recipe title and duration',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildSimpleRecipe();

        await tester.pumpApp(RecipeThumbnail(recipe: recipe));

        expect(find.text(recipe.title), findsOneWidget);
        expect(find.text(recipe.duration), findsOneWidget);
      },
    );
  });

  group(RecipesGridView, () {
    testWidgets(
      'renders a thumbnail for each recipe',
      tags: [TestTag.widget],
      (tester) async {
        final recipes = List.generate(2, (index) => buildSimpleRecipe());

        await tester.pumpApp(RecipesGridView(recipes: recipes));

        expect(find.byType(RecipeThumbnail), findsNWidgets(2));
      },
    );
  });
}
