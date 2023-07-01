import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginData extends ChangeNotifier {
  String _userEmail = '';
  String _role = '';

  String get getUserEmail => _userEmail;

  set setUserEmail(String value) {
    _userEmail = value;
    notifyListeners();
  }

  String get getRole => _role;

  set setRole(String value) {
    _role = value;
    notifyListeners();
  }
}