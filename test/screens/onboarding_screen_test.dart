import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/onboarding_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(OnboardingScreen, () {
    testWidgets(
      'renders the title and first page',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const OnboardingScreen());

        expect(find.text('Getting started'), findsOneWidget);
        expect(find.text('Skip'), findsOneWidget);
        expect(find.textContaining('weekly recommended'), findsOneWidget);
      },
    );

    testWidgets(
      'completes onboarding when skip is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final appStateManager = AppStateManager();

        await tester.pumpApp(
          const OnboardingScreen(),
          appStateManager: appStateManager,
        );

        await tester.tap(find.text('Skip'));
        await tester.pump();

        expect(appStateManager.isOnboardingComplete, isTrue);
      },
    );

    testWidgets(
      'pops the screen when the back arrow is tapped',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const OnboardingScreen());

        await tester.tap(find.byIcon(Icons.chevron_left));
        await tester.pumpAndSettle();
      },
    );
  });
}
