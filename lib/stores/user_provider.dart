import 'package:flutter/foundation.dart';

// Class to hold user information
class UserProvider extends ChangeNotifier {
  String? _userName;
  int? _userID;
  String? _userRole;
  
  String? get userName => _userName;
  int? get userID => _userID;
  String? get userRole => _userRole;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserID(int userID) {
    _userID = userID;
    notifyListeners();
  }

  void setUserRole(String userRole) {
    _userRole = userRole;
    notifyListeners();
  }

  void logout() {
    // Clear user information on logout
    _userName = null;
    _userID = null;
    _userRole = null;
    notifyListeners();
  }
}
