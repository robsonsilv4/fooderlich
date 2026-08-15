import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/grocery_list_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(GroceryListScreen, () {
    late GroceryManager manager;

    setUp(() {
      manager = GroceryManager();
    });

    testWidgets(
      'renders one tile per grocery item',
      tags: [TestTag.widget],
      (tester) async {
        manager
          ..addItem(buildGroceryItem())
          ..addItem(buildGroceryItem());
        await tester.pumpApp(GroceryListScreen(manager: manager));

        expect(find.byType(GroceryListScreen), findsOneWidget);
      },
    );

    testWidgets(
      'dismissing an item deletes it and shows a snackbar',
      tags: [TestTag.widget],
      (tester) async {
        manager.addItem(buildGroceryItem());
        await tester.pumpApp(GroceryListScreen(manager: manager));

        await tester.drag(find.byType(Dismissible), const Offset(-500, 0));
        await tester.pumpAndSettle();

        expect(manager.groceryItems, isEmpty);
        expect(find.text('Milk dismissed'), findsOneWidget);
      },
    );

    testWidgets(
      'selects an item when it is tapped',
      tags: [TestTag.widget],
      (tester) async {
        manager.addItem(buildGroceryItem());
        await tester.pumpApp(GroceryListScreen(manager: manager));

        await tester.tap(find.text('Milk'));
        await tester.pump();

        expect(manager.selectedIndex, equals(0));
      },
    );

    testWidgets(
      'completes an item when the checkbox is toggled',
      tags: [TestTag.widget],
      (tester) async {
        manager.addItem(buildGroceryItem());
        await tester.pumpApp(GroceryListScreen(manager: manager));

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        expect(manager.groceryItems.first.isComplete, isTrue);
      },
    );
  });
}
