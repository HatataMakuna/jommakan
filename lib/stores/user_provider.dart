import 'package:flutter/foundation.dart';

// Class to hold current user information
class UserProvider extends ChangeNotifier {
  String? _userName;
  int? _userID;
  String? _userRole;
  String? _userEmail;
  
  String? get userName => _userName;
  int? get userID => _userID;
  String? get userRole => _userRole;
  String? get userEmail => _userEmail;

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

  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    // Clear user information on logout
    _userName = null;
    _userID = null;
    _userRole = null;
    _userEmail = null;
    notifyListeners();
  }
}
