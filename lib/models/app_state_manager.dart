import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:fooderlich/models/models.dart';

class FooderlichTab {
  static const explore = 0;
  static const recipes = 1;
  static const toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = FooderlichTab.explore;
  final _appCache = AppCache();

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get selectedTab => _selectedTab;

  Future<void> initializeApp() async {
    _loggedIn = await _appCache.isUserLoggedIn();
    _onboardingComplete = await _appCache.didCompleteOnboarding();

    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  Future<void> login(String username, String password) async {
    _loggedIn = true;
    await _appCache.cacheUser();
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipesTab() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  Future<void> logOut() async {
    _initialized = false;
    _selectedTab = 0;
    await _appCache.invalidate();
    initializeApp();
    notifyListeners();
  }
}
