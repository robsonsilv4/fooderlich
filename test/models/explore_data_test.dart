import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(ExploreData, () {
    test(
      'stores today recipes and friend posts',
      tags: [TestTag.unit],
      () {
        final recipes = <ExploreRecipe>[
          ExploreRecipe(id: '1', cardType: 'card1', title: 'Bread'),
        ];
        final posts = <Post>[Post(id: '1', profileImageUrl: '', comment: '', foodPictureUrl: '', timestamp: '')];

        final data = ExploreData(recipes, posts);

        expect(data.todayRecipes, same(recipes));
        expect(data.friendPosts, same(posts));
      },
    );
  });
}
