import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/navigation/navigation.dart';
import 'package:fooderlich/screens/screens.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  AppRouter({
    required this.appStateManager,
    required this.profileManager,
    required this.groceryManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
  }
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;

  @override
  GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onDidRemovePage: _handleDidRemovePage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.route(),
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),
        if (appStateManager.isOnboardingComplete)
          HomeScreen.page(appStateManager.selectedTab),
        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            onCreate: groceryManager.addItem,
            onUpdate: (item, index) {},
          ),
        if (groceryManager.selectedIndex != -1)
          GroceryItemScreen.page(
            item: groceryManager.selectedGroceryItem,
            index: groceryManager.selectedIndex,
            onCreate: (_) {},
            onUpdate: groceryManager.updateItem,
          ),
        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),
        if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
      ],
    );
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    super.dispose();
  }

  // Web and deep linking
  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    switch (configuration.location) {
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(selected: true);
      case AppLink.kItemPath:
        final itemId = configuration.itemId;
        if (itemId != null) {
          groceryManager.setSelectedGroceryItem(itemId);
        } else {
          groceryManager.createNewItem();
        }
        profileManager.tapOnProfile(selected: false);
      case AppLink.kHomePath:
        appStateManager.goToTab(configuration.currentTab ?? 0);
        profileManager.tapOnProfile(selected: false);
        groceryManager.groceryItemTapped(-1);
      default:
        break;
    }
  }

  @override
  AppLink get currentConfiguration => _getCurrentPath();

  AppLink _getCurrentPath() {
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.kItemPath);
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.kItemPath, itemId: id);
    } else {
      return AppLink(
        location: AppLink.kHomePath,
        currentTab: appStateManager.selectedTab,
      );
    }
  }

  void _handleDidRemovePage(Page<Object?> page) {
    if (page.name == FooderlichPages.onboardingPath) {
      unawaited(appStateManager.logOut());
    }

    if (page.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }

    if (page.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(selected: false);
    }

    if (page.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRayderlich(selected: false);
    }
  }
}
