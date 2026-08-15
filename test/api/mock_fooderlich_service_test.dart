import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(MockFooderlichService, () {
    late MockFooderlichService service;

    setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

    setUp(() {
      service = MockFooderlichService();
    });

    group('getExploreData', () {
      test(
        'returns today recipes and friend posts',
        tags: [TestTag.unit],
        () async {
          final data = await service.getExploreData();

          expect(data.todayRecipes, isNotEmpty);
          expect(data.friendPosts, isNotEmpty);
          expect(
            data.todayRecipes.first,
            isA<ExploreRecipe>(),
          );
          expect(data.friendPosts.first, isA<Post>());
        },
      );
    });

    group('getRecipes', () {
      test(
        'returns a list of simple recipes',
        tags: [TestTag.unit],
        () async {
          final recipes = await service.getRecipes();

          expect(recipes, isNotEmpty);
          expect(recipes.first, isA<SimpleRecipe>());
        },
      );
    });
  });
}
