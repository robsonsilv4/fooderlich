import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/main.dart';
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
  });
}
