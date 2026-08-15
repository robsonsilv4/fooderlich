import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/card_one.dart';

import '../helpers/helpers.dart';

void main() {
  group(CardOne, () {
    testWidgets(
      'renders recipe title, subtitle, message and author',
      tags: [TestTag.widget],
      (tester) async {
        final recipe = buildExploreRecipe();

        await tester.pumpApp(CardOne(recipe: recipe));

        expect(find.text(recipe.title), findsOneWidget);
        expect(find.text(recipe.subtitle), findsOneWidget);
        expect(find.text(recipe.message), findsOneWidget);
        expect(find.text(recipe.authorName), findsOneWidget);
      },
    );
  });
}
