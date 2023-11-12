import 'package:flutter/foundation.dart';

// Class to hold user information
class UserProvider extends ChangeNotifier {
  String? _userName;

  String? get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void logout() {
    // Clear user information on logout
    _userName = null;
    notifyListeners();
  }
}
