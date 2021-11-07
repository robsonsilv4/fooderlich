import 'package:flutter/cupertino.dart';

import 'navigation.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  Future<AppLink> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return AppLink.fromLocation(routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(AppLink configuration) {
    final location = configuration.toLocation();
    return RouteInformation(location: location);
  }
}
