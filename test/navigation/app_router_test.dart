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
      stubWebViewPlatform();
      appStateManager = AppStateManager();
      profileManager = ProfileManager();
      groceryManager = GroceryManager();
    });

    AppRouter buildRouter() {
      return AppRouter(
        appStateManager: appStateManager,
        profileManager: profileManager,
        groceryManager: groceryManager,
      );
    }

    Future<void> logInAndCompleteOnboarding() async {
      await appStateManager.login('user', 'pass');
      await appStateManager.completeOnboarding();
    }

    late AppRouter router;

    Future<void> pumpRouter(WidgetTester tester) async {
      router = buildRouter();
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

        expect(find.byType(ProfileScreen), findsOneWidget);
      },
    );

    testWidgets(
      'shows the grocery item screen when creating a new item',
      tags: [TestTag.widget],
      (tester) async {
        await logInAndCompleteOnboarding();
        groceryManager.createNewItem();

        await pumpRouter(tester);

        expect(find.text('Grocery item'), findsOneWidget);
      },
    );

    testWidgets(
      'shows the grocery item screen when an item is selected',
      tags: [TestTag.widget],
      (tester) async {
        await logInAndCompleteOnboarding();
        final item = buildGroceryItem();
        groceryManager
          ..addItem(item)
          ..groceryItemTapped(0);

        await pumpRouter(tester);

        expect(find.text('Grocery item'), findsOneWidget);
      },
    );

    testWidgets(
      'shows the web view when raywenderlich is selected',
      tags: [TestTag.widget],
      (tester) async {
        profileManager.tapOnRayderlich(selected: true);

        await pumpRouter(tester);
        await tester.pump();

        expect(find.text('raywenderlich.com'), findsOneWidget);
      },
    );

    group('setNewRoutePath', () {
      test(
        'selects the profile on the profile path',
        tags: [TestTag.unit],
        () async {
          final router = buildRouter();

          await router.setNewRoutePath(
            AppLink(location: AppLink.kProfilePath),
          );

          expect(profileManager.didSelectUser, isTrue);
        },
      );

      test(
        'selects the grocery item on the item path',
        tags: [TestTag.unit],
        () async {
          final item = buildGroceryItem();
          groceryManager.addItem(item);
          final router = buildRouter();

          await router.setNewRoutePath(
            AppLink(location: AppLink.kItemPath, itemId: '1'),
          );

          expect(groceryManager.selectedGroceryItem?.id, equals('1'));
        },
      );

      test(
        'creates a new item when the item path has no id',
        tags: [TestTag.unit],
        () async {
          final router = buildRouter();

          await router.setNewRoutePath(
            AppLink(location: AppLink.kItemPath),
          );

          expect(groceryManager.isCreatingNewItem, isTrue);
        },
      );

      test(
        'goes to the home tab on the home path',
        tags: [TestTag.unit],
        () async {
          final router = buildRouter();

          await router.setNewRoutePath(
            AppLink(location: AppLink.kHomePath, currentTab: 2),
          );

          expect(appStateManager.selectedTab, equals(FooderlichTab.toBuy));
        },
      );

      test(
        'ignores unknown paths',
        tags: [TestTag.unit],
        () async {
          final router = buildRouter();

          await router.setNewRoutePath(
            AppLink(location: '/unknown'),
          );

          expect(profileManager.didSelectUser, isFalse);
        },
      );
    });

    group('currentConfiguration', () {
      test(
        'returns the login path when not logged in',
        tags: [TestTag.unit],
        () {
          final router = buildRouter();

          expect(
            router.currentConfiguration.location,
            equals(AppLink.kLoginPath),
          );
        },
      );

      test(
        'returns the onboarding path when onboarding is incomplete',
        tags: [TestTag.unit],
        () async {
          await appStateManager.login('user', 'pass');
          final router = buildRouter();

          expect(
            router.currentConfiguration.location,
            equals(AppLink.kOnboardingPath),
          );
        },
      );

      test(
        'returns the item path when creating a new item',
        tags: [TestTag.unit],
        () async {
          await logInAndCompleteOnboarding();
          groceryManager.createNewItem();
          final router = buildRouter();

          expect(
            router.currentConfiguration.location,
            equals(AppLink.kItemPath),
          );
        },
      );

      test(
        'returns the item path with id when an item is selected',
        tags: [TestTag.unit],
        () async {
          await logInAndCompleteOnboarding();
          final item = buildGroceryItem();
          groceryManager
            ..addItem(item)
            ..groceryItemTapped(0);
          final router = buildRouter();

          final config = router.currentConfiguration;

          expect(config.location, equals(AppLink.kItemPath));
          expect(config.itemId, equals('1'));
        },
      );

      test(
        'returns the profile path when a user is selected',
        tags: [TestTag.unit],
        () async {
          await logInAndCompleteOnboarding();
          profileManager.tapOnProfile(selected: true);
          final router = buildRouter();

          expect(
            router.currentConfiguration.location,
            equals(AppLink.kProfilePath),
          );
        },
      );

      test(
        'returns the home path with the current tab',
        tags: [TestTag.unit],
        () async {
          await logInAndCompleteOnboarding();
          appStateManager.goToTab(FooderlichTab.toBuy);
          final router = buildRouter();

          final config = router.currentConfiguration;

          expect(config.location, equals(AppLink.kHomePath));
          expect(config.currentTab, equals(FooderlichTab.toBuy));
        },
      );
    });
    group('page removal', () {
      testWidgets(
        'logs out when the onboarding page is popped',
        tags: [TestTag.widget],
        (tester) async {
          await appStateManager.login('user', 'pass');

          await pumpRouter(tester);

          await tester.tap(find.byIcon(Icons.chevron_left));
          await tester.pumpAndSettle();
          await tester.pump(const Duration(milliseconds: 2100));

          expect(appStateManager.isLoggedIn, isFalse);
        },
      );

      testWidgets(
        'clears the grocery selection when the item page is popped',
        tags: [TestTag.widget],
        (tester) async {
          await logInAndCompleteOnboarding();
          final item = buildGroceryItem();
          groceryManager
            ..addItem(item)
            ..groceryItemTapped(0);

          await pumpRouter(tester);

          await tester.pageBack();
          await tester.pumpAndSettle();

          expect(groceryManager.selectedIndex, equals(-1));
        },
      );

      testWidgets(
        'clears the profile selection when the profile page is popped',
        tags: [TestTag.widget],
        (tester) async {
          await logInAndCompleteOnboarding();
          profileManager.tapOnProfile(selected: true);

          await pumpRouter(tester);

          final popped = router.navigatorKey.currentState!.maybePop();
          await tester.pumpAndSettle();

          expect(popped, isNotNull);
          expect(profileManager.didSelectUser, isFalse);
        },
      );

      testWidgets(
        'clears the raywenderlich flag when the web view is popped',
        tags: [TestTag.widget],
        (tester) async {
          await logInAndCompleteOnboarding();
          profileManager.tapOnRayderlich(selected: true);

          await pumpRouter(tester);
          await tester.pump();

          await tester.pageBack();
          await tester.pumpAndSettle();

          expect(profileManager.didTapOnRaywenderlich, isFalse);
        },
      );
    });

    group('dispose', () {
      test(
        'removes all listeners without throwing',
        tags: [TestTag.unit],
        () {
          final router = buildRouter();
          appStateManager.addListener(router.notifyListeners);

          router.dispose();

          appStateManager.notifyListeners();
          expect(appStateManager, isNotNull);
        },
      );
    });
  });
}
