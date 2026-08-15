import 'package:flutter/cupertino.dart';

import 'package:fooderlich/navigation/navigation.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  Future<AppLink> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return AppLink.fromLocation(routeInformation.uri.toString());
  }

  @override
  RouteInformation restoreRouteInformation(AppLink configuration) {
    final location = configuration.toLocation();
    return RouteInformation(uri: Uri.parse(location));
  }
}
