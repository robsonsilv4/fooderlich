import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helpers.dart';

void main() {
  group(AppStateManager, () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
    });

    test(
      'starts uninitialized, logged out and on explore tab',
      tags: [TestTag.unit],
      () {
        final manager = AppStateManager();

        expect(manager.isInitialized, isFalse);
        expect(manager.isLoggedIn, isFalse);
        expect(manager.isOnboardingComplete, isFalse);
        expect(manager.selectedTab, equals(FooderlichTab.explore));
      },
    );

    group('initializeApp', () {
      test(
        'marks app as initialized after the timer elapses',
        tags: [TestTag.unit],
        () {
          fakeAsync((async) {
            final manager = AppStateManager();

            final future = manager.initializeApp();
            async.elapse(const Duration(milliseconds: 2000));
            future.then((_) {});

            expect(manager.isInitialized, isTrue);
          });
        },
      );

      test(
        'restores login and onboarding state from cache',
        tags: [TestTag.unit],
        () {
          SharedPreferences.setMockInitialValues(<String, Object>{
            AppCache.kUser: true,
            AppCache.kOnboarding: true,
          });

          fakeAsync((async) {
            final manager = AppStateManager();

            final future = manager.initializeApp();
            async.flushMicrotasks();
            async.elapse(const Duration(milliseconds: 2000));
            future.then((_) {});

            expect(manager.isLoggedIn, isTrue);
            expect(manager.isOnboardingComplete, isTrue);
          });
        },
      );
    });

    group('login', () {
      test(
        'marks the user as logged in',
        tags: [TestTag.unit],
        () async {
          final manager = AppStateManager();

          await manager.login('username', 'password');

          expect(manager.isLoggedIn, isTrue);
        },
      );
    });

    group('completeOnboarding', () {
      test(
        'marks onboarding as complete',
        tags: [TestTag.unit],
        () async {
          final manager = AppStateManager();

          await manager.completeOnboarding();

          expect(manager.isOnboardingComplete, isTrue);
        },
      );
    });

    group('goToTab', () {
      test(
        'selects the given tab',
        tags: [TestTag.unit],
        () {
          final manager = AppStateManager();

          manager.goToTab(FooderlichTab.toBuy);

          expect(manager.selectedTab, equals(FooderlichTab.toBuy));
        },
      );
    });

    group('goToRecipesTab', () {
      test(
        'selects the recipes tab',
        tags: [TestTag.unit],
        () {
          final manager = AppStateManager();

          manager.goToRecipesTab();

          expect(manager.selectedTab, equals(FooderlichTab.recipes));
        },
      );
    });

    group('logOut', () {
      test(
        'resets state and re-initializes',
        tags: [TestTag.unit],
        () {
          fakeAsync((async) {
            final manager = AppStateManager();

            manager.goToTab(FooderlichTab.toBuy);
            final future = manager.logOut();
            async.elapse(const Duration(milliseconds: 2000));
            future.then((_) {});

            expect(manager.selectedTab, equals(FooderlichTab.explore));
            expect(manager.isLoggedIn, isFalse);
            expect(manager.isInitialized, isTrue);
          });
        },
      );
    });
  });
}
