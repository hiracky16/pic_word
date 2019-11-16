import 'package:flutter/material.dart';

class Word extends ChangeNotifier {
  String _word;

  void setWord(String value) {
    this._word = value;
    notifyListeners();
  }

  String get word => this._word;
}
