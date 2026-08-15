import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/webview_screen.dart';

import '../helpers/helpers.dart';

void main() {
  group(WebViewScreen, () {
    setUp(stubWebViewPlatform);

    testWidgets(
      'renders the app bar title',
      tags: [TestTag.widget],
      (tester) async {
        await tester.runAsync(() async {
          await tester.pumpApp(const WebViewScreen());
          await tester.pump();
        });

        expect(find.text('raywenderlich.com'), findsOneWidget);
      },
    );

    testWidgets(
      'page() returns a page with the raywenderlich path',
      tags: [TestTag.widget],
      (tester) async {
        final page = WebViewScreen.page();

        expect(page.name, equals(FooderlichPages.raywenderlich));
        expect(page.child, isA<WebViewScreen>());
      },
    );
  });
}
