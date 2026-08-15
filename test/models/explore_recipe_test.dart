import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(ExploreRecipe, () {
    group('fromJson', () {
      const authorImageJson = <String, dynamic>{
        'id': '1',
        'cardType': 'card1',
        'title': 'The Art of Dough',
        'authorImage': 'assets/profile_pics/person_ray.jpeg',
        'ingredients': <Map<String, dynamic>>[
          <String, dynamic>{
            'imageUrl': 'food_flour.jpg',
            'title': 'Flour',
            'source': 'https://pixabay.com',
          },
        ],
        'instructions': <Map<String, dynamic>>[
          <String, dynamic>{
            'imageUrl': 'food_flour.jpg',
            'description': 'Pour the flour on the table.',
            'durationInMinutes': 5,
          },
        ],
        'tags': <String>['Carbs', 'Dough'],
      };

      test(
        'maps authorImage to profileImage',
        tags: [TestTag.unit],
        () {
          final recipe = ExploreRecipe.fromJson(authorImageJson);

          expect(
            recipe.profileImage,
            equals('assets/profile_pics/person_ray.jpeg'),
          );
        },
      );

      test(
        'maps profileImage when authorImage is absent',
        tags: [TestTag.unit],
        () {
          final recipe = ExploreRecipe.fromJson(const <String, dynamic>{
            'id': '2',
            'cardType': 'card2',
            'title': 'Smoothie',
            'profileImage': 'assets/profile_pics/person_katz.jpeg',
          });

          expect(
            recipe.profileImage,
            equals('assets/profile_pics/person_katz.jpeg'),
          );
        },
      );

      test(
        'defaults to empty profileImage when neither key is present',
        tags: [TestTag.unit],
        () {
          final recipe = ExploreRecipe.fromJson(const <String, dynamic>{
            'id': '4',
            'cardType': 'card3',
            'title': 'Carrot',
          });

          expect(recipe.profileImage, isEmpty);
        },
      );
    });
  });
}
