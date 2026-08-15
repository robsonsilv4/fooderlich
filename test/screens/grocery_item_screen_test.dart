import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(GroceryItemScreen, () {
    testWidgets(
      'renders the item form fields',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (_) {},
            onUpdate: (_, __) {},
          ),
        );

        expect(find.text('Grocery item'), findsOneWidget);
        expect(find.text('Item name'), findsOneWidget);
        expect(find.text('Importance'), findsOneWidget);
        expect(find.text('Date'), findsOneWidget);
        expect(find.text('Time of day'), findsOneWidget);
        expect(find.text('Color'), findsOneWidget);
        expect(find.text('Quantity'), findsOneWidget);
      },
    );

    testWidgets(
      'creates a grocery item when the check button is tapped',
      tags: [TestTag.widget],
      (tester) async {
        GroceryItem? created;

        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (item) => created = item,
            onUpdate: (_, __) {},
          ),
        );

        await tester.enterText(find.byType(TextField), 'Apples');
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        expect(created, isNotNull);
        expect(created!.name, equals('Apples'));
        expect(created!.id, isNotEmpty);
      },
    );

    testWidgets(
      'updates an item when editing',
      tags: [TestTag.widget],
      (tester) async {
        final original = buildGroceryItem();
        GroceryItem? updated;

        await tester.pumpApp(
          GroceryItemScreen(
            originalItem: original,
            index: 0,
            onCreate: (_) {},
            onUpdate: (item, index) => updated = item,
          ),
        );

        await tester.enterText(find.byType(TextField), 'Bananas');
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        expect(updated, isNotNull);
        expect(updated!.id, equals(original.id));
        expect(updated!.name, equals('Bananas'));
      },
    );

    testWidgets(
      'changes importance when a chip is selected',
      tags: [TestTag.widget],
      (tester) async {
        GroceryItem? created;

        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (item) => created = item,
            onUpdate: (_, __) {},
          ),
        );

        await tester.tap(find.text('high'));
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        expect(created!.importance, equals(Importance.high));
      },
    );

    testWidgets(
      'selects low importance',
      tags: [TestTag.widget],
      (tester) async {
        GroceryItem? created;

        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (item) => created = item,
            onUpdate: (_, __) {},
          ),
        );

        await tester.tap(find.text('low'));
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        expect(created!.importance, equals(Importance.low));
      },
    );

    testWidgets(
      'selects medium importance',
      tags: [TestTag.widget],
      (tester) async {
        GroceryItem? created;

        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (item) => created = item,
            onUpdate: (_, __) {},
          ),
        );

        await tester.tap(find.text('medium'));
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        expect(created!.importance, equals(Importance.medium));
      },
    );

    testWidgets(
      'updates the due date from the date picker',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (_) {},
            onUpdate: (_, __) {},
          ),
        );

        final dateSelect = find.descendant(
          of: find.byType(Row),
          matching: find.text('Select'),
        );
        await tester.tap(dateSelect.first);
        await tester.pumpAndSettle();

        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'updates the time from the time picker',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (_) {},
            onUpdate: (_, __) {},
          ),
        );

        final timeSelect = find.descendant(
          of: find.byType(Row),
          matching: find.text('Select'),
        );
        await tester.tap(timeSelect.at(1));
        await tester.pumpAndSettle();

        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'selects a color from the color picker',
      tags: [TestTag.widget],
      (tester) async {
        tester.view.physicalSize = const Size(800, 1600);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        GroceryItem? created;

        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (item) => created = item,
            onUpdate: (_, __) {},
          ),
        );

        final colorSelect = find.descendant(
          of: find.byType(Row),
          matching: find.text('Select'),
        );
        await tester.tap(colorSelect.last);
        await tester.pumpAndSettle();

        final colorBlock = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(InkWell),
        );
        await tester.tap(colorBlock.first);
        await tester.pump();
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        expect(created, isNotNull);
      },
    );

    testWidgets(
      'changes quantity when the slider is dragged',
      tags: [TestTag.widget],
      (tester) async {
        GroceryItem? created;

        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (item) => created = item,
            onUpdate: (_, __) {},
          ),
        );

        await tester.drag(find.byType(Slider), const Offset(100, 0));
        await tester.pump();
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        expect(created!.quantity, greaterThan(0));
      },
    );

    testWidgets(
      'opens the color picker dialog',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          GroceryItemScreen(
            onCreate: (_) {},
            onUpdate: (_, __) {},
          ),
        );

        final colorSelect = find.descendant(
          of: find.byType(Row),
          matching: find.text('Select'),
        );
        await tester.tap(colorSelect.last);
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
      },
    );

    testWidgets(
      'page() returns a page with the grocery item path',
      tags: [TestTag.widget],
      (tester) async {
        final page = GroceryItemScreen.page(
          onCreate: (_) {},
          onUpdate: (_, __) {},
        );

        expect(page.name, equals(FooderlichPages.groceryItemDetails));
        expect(page.child, isA<GroceryItemScreen>());
      },
    );
  });
}
