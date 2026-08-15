import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/profile_sreen.dart';

import '../helpers/helpers.dart';

void main() {
  group(ProfileScreen, () {
    User buildUser({bool darkMode = false}) {
      return User(
        firstName: 'Robson',
        lastName: 'Silva',
        role: 'Flutterista',
        profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
        points: 100,
        darkMode: darkMode,
      );
    }

    testWidgets(
      'renders user profile info',
      tags: [TestTag.widget],
      (tester) async {
        final user = buildUser();

        await tester.pumpApp(ProfileScreen(user: user));

        expect(find.text(user.firstName), findsOneWidget);
        expect(find.text(user.role), findsOneWidget);
        expect(find.text('${user.points} points'), findsOneWidget);
        expect(find.text('Dark mode'), findsOneWidget);
      },
    );

    testWidgets(
      'toggles dark mode through the profile manager',
      tags: [TestTag.widget],
      (tester) async {
        final profileManager = ProfileManager();
        final user = buildUser();

        await tester.pumpApp(
          ProfileScreen(user: user),
          profileManager: profileManager,
        );

        await tester.tap(find.byType(Switch));
        await tester.pump();

        expect(profileManager.darkMode, isTrue);
      },
    );

    testWidgets(
      'calls tapOnRayderlich when the link is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final profileManager = ProfileManager();
        final user = buildUser();

        await tester.pumpApp(
          ProfileScreen(user: user),
          profileManager: profileManager,
        );

        await tester.tap(find.text('View raywenderlich.com'));
        await tester.pump();

        expect(profileManager.didTapOnRaywenderlich, isTrue);
      },
    );

    testWidgets(
      'clears profile selection when close is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final profileManager = ProfileManager()..tapOnProfile(selected: true);
        final user = buildUser();

        await tester.pumpApp(
          ProfileScreen(user: user),
          profileManager: profileManager,
        );

        await tester.tap(find.byIcon(Icons.close));
        await tester.pump();

        expect(profileManager.didSelectUser, isFalse);
      },
    );
  });
}
