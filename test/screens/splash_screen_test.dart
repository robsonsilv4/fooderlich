import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/splash_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(SplashScreen, () {
    testWidgets(
      'renders logo and initializing text',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(const SplashScreen());
        await tester.pump();

        expect(find.text('Initializing...'), findsOneWidget);
      },
    );

    testWidgets(
      'page() returns a page with the splash path',
      tags: [TestTag.widget],
      (tester) async {
        final page = SplashScreen.page();

        expect(page.name, equals(FooderlichPages.splashPath));
        expect(page.child, isA<SplashScreen>());
      },
    );
  });
}
