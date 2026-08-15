import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/navigation/navigation.dart';
import 'package:fooderlich/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helpers.dart';

void main() {
  group(AppRouter, () {
    late AppStateManager appStateManager;
    late ProfileManager profileManager;
    late GroceryManager groceryManager;

    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      appStateManager = AppStateManager();
      profileManager = ProfileManager();
      groceryManager = GroceryManager();
    });

    Future<void> pumpRouter(WidgetTester tester) async {
      final router = AppRouter(
        appStateManager: appStateManager,
        profileManager: profileManager,
        groceryManager: groceryManager,
      );
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: appStateManager),
            ChangeNotifierProvider.value(value: profileManager),
            ChangeNotifierProvider.value(value: groceryManager),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) => Router(
                routerDelegate: router,
                routeInformationParser: AppRouteParser(),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 2100));
      await tester.pump();
    }

    testWidgets(
      'shows the splash screen before initialization',
      tags: [TestTag.widget],
      (tester) async {
        await pumpRouter(tester);
        await tester.pump();

        expect(find.text('Initializing...'), findsOneWidget);
      },
    );

    testWidgets(
      'shows the login screen after initialization',
      tags: [TestTag.widget],
      (tester) async {
        await pumpRouter(tester);
        await tester.pump(const Duration(milliseconds: 2100));

        expect(find.text('Login'), findsOneWidget);
      },
    );

    testWidgets(
      'shows the onboarding screen after login',
      tags: [TestTag.widget],
      (tester) async {
        await pumpRouter(tester);
        await tester.pump(const Duration(milliseconds: 2100));

        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        expect(find.text('Getting started'), findsOneWidget);
      },
    );

    testWidgets(
      'navigates to the home screen when onboarding completes',
      tags: [TestTag.widget],
      (tester) async {
        await pumpRouter(tester);
        await tester.pump(const Duration(milliseconds: 2100));

        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Skip'));
        await tester.pumpAndSettle();

        expect(find.text('Fooderlish'), findsOneWidget);
      },
    );

    testWidgets(
      'shows the profile screen when a user is selected',
      tags: [TestTag.widget],
      (tester) async {
        profileManager.tapOnProfile(selected: true);

        await pumpRouter(tester);
        await tester.pump(const Duration(milliseconds: 2100));

        expect(find.byType(ProfileScreen), findsOneWidget);
      },
    );
  });
}
