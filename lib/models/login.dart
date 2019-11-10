import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends ChangeNotifier {
  String _email;
  String _password;
  FirebaseUser _user;

  void setEmail(String value) {
    this._email = value;
    // notifyListeners();
  }

  String get email => this._email;

  void setPassword(String value) {
    this._password = value;
    // notifyListeners();
  }

  String get password => this._password;

  void setUser(FirebaseUser user) {
    this._user = user;
  }

  FirebaseUser get user => this._user;
}
