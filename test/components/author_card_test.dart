import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/author_card.dart';

import '../helpers/helpers.dart';

void main() {
  group(AuthorCard, () {
    testWidgets(
      'renders author name and title',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          const AuthorCard(
            authorName: 'Ray Wenderlich',
            title: 'Founder',
          ),
        );

        expect(find.text('Ray Wenderlich'), findsOneWidget);
        expect(find.text('Founder'), findsOneWidget);
      },
    );

    testWidgets(
      'starts with a favorite border icon',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          const AuthorCard(
            authorName: 'Ray Wenderlich',
            title: 'Founder',
          ),
        );

        expect(find.byIcon(Icons.favorite_border), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsNothing);
      },
    );

    testWidgets(
      'toggles the favorite icon when tapped',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          const AuthorCard(
            authorName: 'Ray Wenderlich',
            title: 'Founder',
          ),
        );

        await tester.tap(find.byType(IconButton));
        await tester.pump();

        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.favorite_border), findsNothing);
      },
    );
  });
}
