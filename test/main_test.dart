import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/main.dart';
import 'package:fooderlich/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/helpers.dart';

void main() {
  group(FooderlishApp, () {
    testWidgets(
      'boots and shows the splash screen',
      tags: [TestTag.widget],
      (tester) async {
        SharedPreferences.setMockInitialValues(<String, Object>{});

        await tester.pumpApp(const FooderlishApp());
        await tester.pump();

        expect(find.text('Initializing...'), findsOneWidget);

        await tester.pump(const Duration(milliseconds: 2100));
      },
    );

    testWidgets(
      'applies the dark theme when dark mode is enabled',
      tags: [TestTag.widget],
      (tester) async {
        SharedPreferences.setMockInitialValues(<String, Object>{});
        final profileManager = ProfileManager()..darkMode = true;

        await tester.pumpApp(
          FooderlishApp(profileManager: profileManager),
        );
        await tester.pump();

        final theme = Theme.of(
          tester.element(find.text('Initializing...')),
        );
        expect(theme.brightness, equals(Brightness.dark));

        await tester.pump(const Duration(milliseconds: 2100));
      },
    );
  });

  group(FooderlichTheme, () {
    test(
      'dark mode flag selects the dark theme',
      tags: [TestTag.unit],
      () {
        expect(FooderlichTheme.dark().brightness, equals(Brightness.dark));
        expect(FooderlichTheme.light().brightness, equals(Brightness.light));
      },
    );
  });
}
