import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/home_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(HomeScreen, () {
    Future<void> pumpHome(WidgetTester tester) async {
      await tester.pumpApp(const HomeScreen(currentTab: 0));
      await tester.pump(const Duration(milliseconds: 1100));
      await tester.pump(const Duration(milliseconds: 1100));
    }

    testWidgets(
      'renders the app bar and bottom navigation',
      tags: [TestTag.widget],
      (tester) async {
        await pumpHome(tester);

        expect(find.text('Fooderlish'), findsOneWidget);
        expect(find.text('Explore'), findsOneWidget);
        expect(find.text('Recipes'), findsOneWidget);
        expect(find.text('To buy'), findsOneWidget);
      },
    );

    testWidgets(
      'page() returns a page with the home path',
      tags: [TestTag.widget],
      (tester) async {
        final page = HomeScreen.page(0);

        expect(page.name, equals(FooderlichPages.homePath));
        expect(page.child, isA<HomeScreen>());
      },
    );

    testWidgets(
      'switches tabs when the bottom navigation is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final appStateManager = AppStateManager();

        await tester.pumpApp(
          const HomeScreen(currentTab: 0),
          appStateManager: appStateManager,
        );
        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 1100));

        await tester.tap(find.text('Recipes'));
        await tester.pump();

        expect(appStateManager.selectedTab, equals(FooderlichTab.recipes));
      },
    );

    testWidgets(
      'opens the profile when the profile button is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final profileManager = ProfileManager();

        await tester.pumpApp(
          const HomeScreen(currentTab: 0),
          profileManager: profileManager,
        );
        await tester.pump(const Duration(milliseconds: 1100));
        await tester.pump(const Duration(milliseconds: 1100));

        await tester.tap(find.byType(CircleAvatar).last);
        await tester.pump();

        expect(profileManager.didSelectUser, isTrue);
      },
    );
  });
}
