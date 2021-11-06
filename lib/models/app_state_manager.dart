import 'dart:async';

import 'package:flutter/foundation.dart';

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

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get selectedTab => _selectedTab;

  void initializeApp() {
    Timer(const Duration(microseconds: 200), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void login(String username, String password) {
    _loggedIn = true;
    notifyListeners();
  }

  void completeOnboarding() {
    _onboardingComplete = true;
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

  void logOut() {
    _initialized = false;
    _loggedIn = false;
    _onboardingComplete = false;
    _selectedTab = 0;
    initializeApp();
    notifyListeners();
  }
}
