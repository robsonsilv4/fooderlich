import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/fooderlich_theme.dart';

import 'helpers/helpers.dart';

void main() {
  group(FooderlichTheme, () {
    test(
      'light() returns a light theme with a text theme',
      tags: [TestTag.unit],
      () {
        final theme = FooderlichTheme.light();

        expect(theme.brightness, equals(Brightness.light));
        expect(theme.textTheme, isNotNull);
      },
    );

    test(
      'dark() returns a dark theme with a text theme',
      tags: [TestTag.unit],
      () {
        final theme = FooderlichTheme.dark();

        expect(theme.brightness, equals(Brightness.dark));
        expect(theme.textTheme, isNotNull);
      },
    );

    test(
      'lightTextTheme exposes the expected text styles',
      tags: [TestTag.unit],
      () {
        final theme = FooderlichTheme.lightTextTheme;

        expect(theme.bodyLarge, isNotNull);
        expect(theme.displaySmall, isNotNull);
        expect(theme.displayMedium, isNotNull);
        expect(theme.displayLarge, isNotNull);
        expect(theme.titleLarge, isNotNull);
      },
    );

    test(
      'darkTextTheme exposes the expected text styles',
      tags: [TestTag.unit],
      () {
        final theme = FooderlichTheme.darkTextTheme;

        expect(theme.bodyLarge, isNotNull);
        expect(theme.displaySmall, isNotNull);
        expect(theme.displayMedium, isNotNull);
        expect(theme.displayLarge, isNotNull);
        expect(theme.titleLarge, isNotNull);
      },
    );
  });
}
