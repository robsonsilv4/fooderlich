import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(User, () {
    test(
      'stores user profile fields',
      tags: [TestTag.unit],
      () {
        final user = User(
          firstName: 'Robson',
          lastName: 'Silva',
          role: 'Flutterista',
          profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
          points: 100,
          darkMode: true,
        );

        expect(user.firstName, equals('Robson'));
        expect(user.lastName, equals('Silva'));
        expect(user.role, equals('Flutterista'));
        expect(user.profileImageUrl,
            equals('assets/profile_pics/person_stef.jpeg'),);
        expect(user.points, equals(100));
        expect(user.darkMode, isTrue);
      },
    );
  });
}
