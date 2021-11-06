import 'package:flutter/foundation.dart';

import 'models.dart';

class ProfileManager extends ChangeNotifier {
  bool _didSelectUser = false;
  bool _tapOnRayderlich = false;
  bool _darkMode = false;

  bool get didSelectUser => _didSelectUser;
  bool get didTapOnRaywenderlich => _tapOnRayderlich;
  bool get darkMode => _darkMode;

  User get getUser => User(
        firstName: 'Robson',
        lastName: 'Silva',
        role: 'Flutterista',
        profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
        points: 100,
        darkMode: _darkMode,
      );

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnRayderlich(bool selected) {
    _tapOnRayderlich = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
