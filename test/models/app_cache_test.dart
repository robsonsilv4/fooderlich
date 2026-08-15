import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/app_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helpers.dart';

void main() {
  group(AppCache, () {
    late AppCache cache;

    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      cache = AppCache();
    });

    test(
      'cacheUser stores the user flag',
      tags: [TestTag.unit],
      () async {
        await cache.cacheUser();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool(AppCache.kUser), isTrue);
      },
    );

    test(
      'completeOnboarding stores the onboarding flag',
      tags: [TestTag.unit],
      () async {
        await cache.completeOnboarding();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool(AppCache.kOnboarding), isTrue);
      },
    );

    test(
      'isUserLoggedIn returns false when not cached',
      tags: [TestTag.unit],
      () async {
        expect(await cache.isUserLoggedIn(), isFalse);
      },
    );

    test(
      'isUserLoggedIn returns true after cacheUser',
      tags: [TestTag.unit],
      () async {
        await cache.cacheUser();

        expect(await cache.isUserLoggedIn(), isTrue);
      },
    );

    test(
      'didCompleteOnboarding returns false when not cached',
      tags: [TestTag.unit],
      () async {
        expect(await cache.didCompleteOnboarding(), isFalse);
      },
    );

    test(
      'didCompleteOnboarding returns true after completeOnboarding',
      tags: [TestTag.unit],
      () async {
        await cache.completeOnboarding();

        expect(await cache.didCompleteOnboarding(), isTrue);
      },
    );

    test(
      'invalidate clears both flags',
      tags: [TestTag.unit],
      () async {
        await cache.cacheUser();
        await cache.completeOnboarding();

        await cache.invalidate();

        expect(await cache.isUserLoggedIn(), isFalse);
        expect(await cache.didCompleteOnboarding(), isFalse);
      },
    );
  });
}
