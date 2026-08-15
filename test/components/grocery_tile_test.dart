import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(GroceryTile, () {
    testWidgets(
      'renders item name, quantity and importance',
      tags: [TestTag.widget],
      (tester) async {
        final item = buildGroceryItem();

        await tester.pumpApp(GroceryTile(item: item));

        expect(find.text(item.name), findsOneWidget);
        expect(find.text(item.quantity.toString()), findsOneWidget);
        expect(find.text('Medium'), findsOneWidget);
      },
    );

    testWidgets(
      'renders low importance',
      tags: [TestTag.widget],
      (tester) async {
        final item = buildGroceryItem(importance: Importance.low);

        await tester.pumpApp(GroceryTile(item: item));

        expect(find.text('Low'), findsOneWidget);
      },
    );

    testWidgets(
      'renders high importance',
      tags: [TestTag.widget],
      (tester) async {
        final item = buildGroceryItem(importance: Importance.high);

        await tester.pumpApp(GroceryTile(item: item));

        expect(find.text('High'), findsOneWidget);
      },
    );

    testWidgets(
      'checks the checkbox when complete',
      tags: [TestTag.widget],
      (tester) async {
        final item = buildGroceryItem();
        final completed = item.copyWith(isComplete: true);

        await tester.pumpApp(GroceryTile(item: completed));

        expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
      },
    );

    testWidgets(
      'calls onComplete when the checkbox is toggled',
      tags: [TestTag.widget],
      (tester) async {
        final item = buildGroceryItem();
        bool? receivedChange;

        await tester.pumpApp(
          GroceryTile(
            item: item,
            onComplete: (change) => receivedChange = change,
          ),
        );

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        expect(receivedChange, isTrue);
      },
    );
  });
}
