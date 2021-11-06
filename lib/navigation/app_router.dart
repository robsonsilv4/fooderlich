import 'package:flutter/widgets.dart';

import '../models/models.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;

  AppRouter({
    required this.appStateManager,
    required this.profileManager,
    required this.groceryManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
  }

  @override
  GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: const [],
    );
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    super.dispose();
  }

  // Flutter web
  @override
  Future<void> setNewRoutePath(configuration) => Future.value(null);

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    return true;
  }
}
