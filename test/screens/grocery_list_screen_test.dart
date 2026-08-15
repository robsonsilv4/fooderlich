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
  });
}
