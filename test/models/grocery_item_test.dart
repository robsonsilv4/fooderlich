import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(GroceryItem, () {
    final date = DateTime(2026, 1, 15);

    GroceryItem buildItem({bool isComplete = false}) {
      return GroceryItem(
        id: '1',
        name: 'Milk',
        importance: Importance.medium,
        color: const Color(0xFF000000),
        quantity: 2,
        date: date,
        isComplete: isComplete,
      );
    }

    test(
      'creates an item with given fields',
      tags: [TestTag.unit],
      () {
        final item = buildItem();

        expect(item.id, equals('1'));
        expect(item.name, equals('Milk'));
        expect(item.importance, equals(Importance.medium));
        expect(item.quantity, equals(2));
        expect(item.date, equals(date));
        expect(item.isComplete, isFalse);
      },
    );

    group('copyWith', () {
      test(
        'returns a copy with all fields unchanged when no arguments',
        tags: [TestTag.unit],
        () {
          final item = buildItem();
          final copy = item.copyWith();

          expect(copy.id, equals(item.id));
          expect(copy.name, equals(item.name));
          expect(copy.importance, equals(item.importance));
          expect(copy.color, equals(item.color));
          expect(copy.quantity, equals(item.quantity));
          expect(copy.date, equals(item.date));
          expect(copy.isComplete, equals(item.isComplete));
        },
      );

      test(
        'updates only the provided fields',
        tags: [TestTag.unit],
        () {
          final item = buildItem();
          final copy = item.copyWith(
            name: 'Bread',
            quantity: 3,
            isComplete: true,
          );

          expect(copy.id, equals(item.id));
          expect(copy.name, equals('Bread'));
          expect(copy.importance, equals(item.importance));
          expect(copy.color, equals(item.color));
          expect(copy.quantity, equals(3));
          expect(copy.date, equals(item.date));
          expect(copy.isComplete, isTrue);
        },
      );
    });
  });
}
