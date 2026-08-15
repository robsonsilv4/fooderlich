import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(ExploreRecipe, () {
    group('fromJson', () {
      const json = <String, dynamic>{
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
          final recipe = ExploreRecipe.fromJson(json);

          expect(
            recipe.profileImage,
            equals('assets/profile_pics/person_ray.jpeg'),
          );
        },
      );
    });
  });
}
