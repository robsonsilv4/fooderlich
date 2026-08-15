import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';

import '../helpers/helpers.dart';

void main() {
  group(FooderlichPages, () {
    test(
      'exposes all route paths',
      tags: [TestTag.unit],
      () {
        expect(FooderlichPages.splashPath, equals('/splash'));
        expect(FooderlichPages.loginPath, equals('/login'));
        expect(FooderlichPages.onboardingPath, equals('/onboarding'));
        expect(FooderlichPages.homePath, equals('/'));
        expect(FooderlichPages.groceryItemDetails, equals('/item'));
        expect(FooderlichPages.profilePath, equals('/profile'));
        expect(FooderlichPages.raywenderlich, equals('/raywenderlich'));
        expect(FooderlichPages.accountPath, equals('/account'));
      },
    );
  });
}
