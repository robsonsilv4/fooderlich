import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(SimpleRecipe, () {
    group('fromJson', () {
      test(
        'returns a $SimpleRecipe with values from json',
        tags: [TestTag.unit],
        () {
          final recipe = SimpleRecipe.fromJson(const <String, dynamic>{
            'id': '1',
            'dishImage': 'assets/food_pics/pizza.png',
            'title': 'Pizza',
            'duration': '30 min',
            'source': 'Pixabay',
            'information': <String>['Italian', 'Main'],
          });

          expect(recipe.id, equals('1'));
          expect(recipe.dishImage, equals('assets/food_pics/pizza.png'));
          expect(recipe.title, equals('Pizza'));
          expect(recipe.duration, equals('30 min'));
          expect(recipe.source, equals('Pixabay'));
          expect(recipe.information, equals(<String>['Italian', 'Main']));
        },
      );
    });
  });
}
