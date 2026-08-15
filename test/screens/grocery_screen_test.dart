import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/empty_grocery_screen.dart';
import 'package:fooderlich/screens/grocery_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(GroceryScreen, () {
    testWidgets(
      'shows the empty grocery screen when there are no items',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const GroceryScreen());

        expect(find.byType(EmptyGroceryScreen), findsOneWidget);
        expect(find.text('No groceries'), findsOneWidget);
      },
    );

    testWidgets(
      'creates a new item when the add button is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final groceryManager = GroceryManager();

        await tester.pumpApp(
          const GroceryScreen(),
          groceryManager: groceryManager,
        );

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();

        expect(groceryManager.isCreatingNewItem, isTrue);
      },
    );
  });
}
