import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/navigation/navigation.dart';

import '../helpers/helpers.dart';

void main() {
  group(AppRouteParser, () {
    late AppRouteParser parser;

    setUp(() {
      parser = AppRouteParser();
    });

    group('parseRouteInformation', () {
      test(
        'returns an $AppLink from a route uri',
        tags: [TestTag.unit],
        () async {
          final link = await parser.parseRouteInformation(
            RouteInformation(uri: Uri.parse('/home?tab=0')),
          );

          expect(link, isA<AppLink>());
          expect(link.location, equals(AppLink.kHomePath));
          expect(link.currentTab, equals(0));
        },
      );
    });

    group('restoreRouteInformation', () {
      test(
        'returns route information from an $AppLink',
        tags: [TestTag.unit],
        () {
          final information = parser.restoreRouteInformation(
            AppLink(location: AppLink.kProfilePath),
          );

          expect(information.uri, equals(Uri.parse(AppLink.kProfilePath)));
        },
      );
    });
  });
}
