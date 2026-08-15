import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/login_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(LoginScreen, () {
    testWidgets(
      'renders login fields and button',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const LoginScreen());

        expect(find.text('Login'), findsOneWidget);
        expect(find.byType(TextField), findsNWidgets(2));
      },
    );

    testWidgets(
      'uses the provided username as hint',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const LoginScreen(username: 'user@example.com'));

        expect(find.text('user@example.com'), findsOneWidget);
      },
    );

    testWidgets(
      'route() returns a route with the login path',
      tags: [TestTag.widget],
      (tester) async {
        final route = LoginScreen.route();

        expect(route.name, equals(FooderlichPages.loginPath));
        expect(route.child, isA<LoginScreen>());
      },
    );

    testWidgets(
      'logs in when the login button is tapped',
      tags: [TestTag.widget],
      (tester) async {
        final appStateManager = AppStateManager();

        await tester.pumpApp(
          const LoginScreen(),
          appStateManager: appStateManager,
        );

        await tester.tap(find.text('Login'));
        await tester.pump();

        expect(appStateManager.isLoggedIn, isTrue);
      },
    );
  });
}
