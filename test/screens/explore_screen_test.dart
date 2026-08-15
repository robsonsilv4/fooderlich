import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/screens/explore_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(ExploreScreen, () {
    testWidgets(
      'shows a progress indicator while loading',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const ExploreScreen());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 1100));
      },
    );

    testWidgets(
      'renders recipe lists once data is loaded',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const ExploreScreen());
        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Recipes of the Day 🍳'), findsOneWidget);
        expect(find.text('Social Chefs 👩‍🍳'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    testWidgets(
      'handles scrolling to the top and bottom',
      tags: [TestTag.widget],
      (tester) async {
        tester.view.physicalSize = const Size(600, 1200);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpApp(const ExploreScreen());
        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 100));

        await tester.drag(find.byType(ListView).first, const Offset(0, -2000));
        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView).first, const Offset(0, 2000));
        await tester.pumpAndSettle();
      },
    );
  });
}
