import 'package:flutter/foundation.dart';

import 'package:fooderlich/models/models.dart';

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
        role: 'Flutter Developer',
        profileImageUrl: 'assets/profile_pics/person_robson.jpeg',
        points: 100,
        darkMode: _darkMode,
      );

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnRayderlich({required bool selected}) {
    _tapOnRayderlich = selected;
    notifyListeners();
  }

  void tapOnProfile({required bool selected}) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
