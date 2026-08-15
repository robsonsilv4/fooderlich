import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/navigation/navigation.dart';

import '../helpers/helpers.dart';

void main() {
  group(AppLink, () {
    group('fromLocation', () {
      test(
        'parses a login path',
        tags: [TestTag.unit],
        () {
          final link = AppLink.fromLocation('/login');

          expect(link.location, equals(AppLink.kLoginPath));
          expect(link.currentTab, isNull);
          expect(link.itemId, isNull);
        },
      );

      test(
        'parses an onboarding path',
        tags: [TestTag.unit],
        () {
          final link = AppLink.fromLocation('/onboarding');

          expect(link.location, equals(AppLink.kOnboardingPath));
        },
      );

      test(
        'parses a home path with tab param',
        tags: [TestTag.unit],
        () {
          final link = AppLink.fromLocation('/home?tab=2');

          expect(link.location, equals(AppLink.kHomePath));
          expect(link.currentTab, equals(2));
        },
      );

      test(
        'parses an item path with id param',
        tags: [TestTag.unit],
        () {
          final link = AppLink.fromLocation('/item?id=42');

          expect(link.location, equals(AppLink.kItemPath));
          expect(link.itemId, equals('42'));
        },
      );

      test(
        'returns null tab when tab is not numeric',
        tags: [TestTag.unit],
        () {
          final link = AppLink.fromLocation('/home?tab=abc');

          expect(link.currentTab, isNull);
        },
      );

      test(
        'handles null location as home path',
        tags: [TestTag.unit],
        () {
          final link = AppLink.fromLocation(null);

          expect(link.location, isEmpty);
        },
      );
    });

    group('toLocation', () {
      test(
        'returns login path unchanged',
        tags: [TestTag.unit],
        () {
          final link = AppLink(location: AppLink.kLoginPath);

          expect(link.toLocation(), equals(AppLink.kLoginPath));
        },
      );

      test(
        'returns onboarding path unchanged',
        tags: [TestTag.unit],
        () {
          final link = AppLink(location: AppLink.kOnboardingPath);

          expect(link.toLocation(), equals(AppLink.kOnboardingPath));
        },
      );

      test(
        'returns profile path unchanged',
        tags: [TestTag.unit],
        () {
          final link = AppLink(location: AppLink.kProfilePath);

          expect(link.toLocation(), equals(AppLink.kProfilePath));
        },
      );

      test(
        'builds item path with id param',
        tags: [TestTag.unit],
        () {
          final link = AppLink(
            location: AppLink.kItemPath,
            itemId: '7',
          );

          expect(link.toLocation(), equals('/item?id=7&'));
        },
      );

      test(
        'builds item path without id when itemId is null',
        tags: [TestTag.unit],
        () {
          final link = AppLink(location: AppLink.kItemPath);

          expect(link.toLocation(), equals('/item?'));
        },
      );

      test(
        'builds home path with tab param',
        tags: [TestTag.unit],
        () {
          final link = AppLink(
            location: AppLink.kHomePath,
            currentTab: 1,
          );

          expect(link.toLocation(), equals('/home?tab=1&'));
        },
      );

      test(
        'builds home path when location is null',
        tags: [TestTag.unit],
        () {
          final link = AppLink();

          expect(link.toLocation(), equals('/home?tab=null&'));
        },
      );

      test(
        'builds home path for unknown locations',
        tags: [TestTag.unit],
        () {
          final link = AppLink(location: '/unknown');

          expect(link.toLocation(), startsWith('/home?'));
        },
      );
    });
  });
}
