import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(ProfileManager, () {
    late ProfileManager manager;

    setUp(() {
      manager = ProfileManager();
    });

    test(
      'starts with default state',
      tags: [TestTag.unit],
      () {
        expect(manager.didSelectUser, isFalse);
        expect(manager.didTapOnRaywenderlich, isFalse);
        expect(manager.darkMode, isFalse);
      },
    );

    group('darkMode', () {
      test(
        'stores the new value',
        tags: [TestTag.unit],
        () {
          manager.darkMode = true;

          expect(manager.darkMode, isTrue);
        },
      );
    });

    group('tapOnRayderlich', () {
      test(
        'stores the selected value',
        tags: [TestTag.unit],
        () {
          manager.tapOnRayderlich(selected: true);

          expect(manager.didTapOnRaywenderlich, isTrue);
        },
      );
    });

    group('tapOnProfile', () {
      test(
        'stores the selected value',
        tags: [TestTag.unit],
        () {
          manager.tapOnProfile(selected: true);

          expect(manager.didSelectUser, isTrue);
        },
      );
    });

    group('getUser', () {
      test(
        'returns the profile user reflecting dark mode',
        tags: [TestTag.unit],
        () {
          manager.darkMode = true;

          final user = manager.getUser;

          expect(user.firstName, equals('Robson'));
          expect(user.lastName, equals('Silva'));
          expect(user.role, equals('Flutterista'));
          expect(user.darkMode, isTrue);
          expect(user.points, equals(100));
        },
      );
    });
  });
}
