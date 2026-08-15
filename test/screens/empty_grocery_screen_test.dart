import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/empty_grocery_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(EmptyGroceryScreen, () {
    testWidgets(
      'renders empty state text and browse button',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const EmptyGroceryScreen());

        expect(find.text('No groceries'), findsOneWidget);
        expect(find.text('Browse recipes'), findsOneWidget);
      },
    );

    testWidgets(
      'navigates to recipes tab when browse is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final appStateManager = AppStateManager();

        await tester.pumpApp(
          const EmptyGroceryScreen(),
          appStateManager: appStateManager,
        );

        await tester.tap(find.text('Browse recipes'));
        await tester.pump();

        expect(appStateManager.selectedTab, equals(FooderlichTab.recipes));
      },
    );
  });
}
