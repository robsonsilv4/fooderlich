import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/components/circle_image.dart';

import '../helpers/helpers.dart';

void main() {
  group(CircleImage, () {
    testWidgets(
      'renders a circle avatar with the given image',
      tags: [TestTag.widget],
      (tester) async {
        await tester.pumpApp(
          const CircleImage(imageRadius: 30),
        );

        expect(find.byType(CircleAvatar), findsNWidgets(2));
      },
    );

    testWidgets(
      'passes the image provider to the inner avatar',
      tags: [TestTag.widget],
      (tester) async {
        const provider = AssetImage('assets/profile_pics/person_ray.jpeg');

        await tester.pumpApp(
          const CircleImage(
            imageRadius: 30,
            imageProvider: provider,
          ),
        );

        final avatar = tester.widget<CircleAvatar>(
          find.byType(CircleAvatar).last,
        );
        expect(avatar.backgroundImage, same(provider));
      },
    );
  });
}
