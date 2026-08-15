import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(GroceryManager, () {
    late GroceryManager manager;

    final date = DateTime(2026, 1, 15);

    GroceryItem buildItem(String id, {bool isComplete = false}) {
      return GroceryItem(
        id: id,
        name: 'Item $id',
        importance: Importance.medium,
        color: const Color(0xFF000000),
        quantity: 1,
        date: date,
        isComplete: isComplete,
      );
    }

    setUp(() {
      manager = GroceryManager();
    });

    test(
      'starts empty with no selection',
      tags: [TestTag.unit],
      () {
        expect(manager.groceryItems, isEmpty);
        expect(manager.selectedIndex, equals(-1));
        expect(manager.selectedGroceryItem, isNull);
        expect(manager.isCreatingNewItem, isFalse);
      },
    );

    group('createNewItem', () {
      test(
        'sets the creating new item flag',
        tags: [TestTag.unit],
        () {
          manager.createNewItem();

          expect(manager.isCreatingNewItem, isTrue);
        },
      );
    });

    group('addItem', () {
      test(
        'adds the item and clears the creating flag',
        tags: [TestTag.unit],
        () {
          final item = buildItem('1');
          manager.createNewItem();

          manager.addItem(item);

          expect(manager.groceryItems, hasLength(1));
          expect(manager.groceryItems.first.id, equals('1'));
          expect(manager.isCreatingNewItem, isFalse);
        },
      );
    });

    group('groceryItemTapped', () {
      test(
        'selects the item at the index',
        tags: [TestTag.unit],
        () {
          manager.addItem(buildItem('1'));
          manager.addItem(buildItem('2'));

          manager.groceryItemTapped(1);

          expect(manager.selectedIndex, equals(1));
          expect(manager.selectedGroceryItem?.id, equals('2'));
        },
      );
    });

    group('setSelectedGroceryItem', () {
      test(
        'selects the item with the given id',
        tags: [TestTag.unit],
        () {
          manager.addItem(buildItem('1'));
          manager.addItem(buildItem('2'));

          manager.setSelectedGroceryItem('1');

          expect(manager.selectedIndex, equals(0));
          expect(manager.selectedGroceryItem?.id, equals('1'));
        },
      );

      test(
        'does not select when no item matches',
        tags: [TestTag.unit],
        () {
          manager.addItem(buildItem('1'));

          manager.setSelectedGroceryItem('nope');

          expect(manager.selectedIndex, equals(-1));
          expect(manager.selectedGroceryItem, isNull);
        },
      );
    });

    group('deleteItem', () {
      test(
        'removes the item at the index',
        tags: [TestTag.unit],
        () {
          manager.addItem(buildItem('1'));
          manager.addItem(buildItem('2'));

          manager.deleteItem(0);

          expect(manager.groceryItems, hasLength(1));
          expect(manager.groceryItems.first.id, equals('2'));
        },
      );
    });

    group('updateItem', () {
      test(
        'replaces the item and clears selection',
        tags: [TestTag.unit],
        () {
          manager.addItem(buildItem('1'));
          manager.groceryItemTapped(0);

          final updated = buildItem('1');
          manager.updateItem(updated, 0);

          expect(manager.groceryItems.first, same(updated));
          expect(manager.selectedIndex, equals(-1));
          expect(manager.selectedGroceryItem, isNull);
        },
      );
    });

    group('completeItem', () {
      test(
        'marks the item as complete',
        tags: [TestTag.unit],
        () {
          manager.addItem(buildItem('1'));

          manager.completeItem(0, change: true);

          expect(manager.groceryItems.first.isComplete, isTrue);
        },
      );

      test(
        'marks the item as incomplete',
        tags: [TestTag.unit],
        () {
          manager.addItem(buildItem('1', isComplete: true));

          manager.completeItem(0, change: false);

          expect(manager.groceryItems.first.isComplete, isFalse);
        },
      );
    });
  });
}
