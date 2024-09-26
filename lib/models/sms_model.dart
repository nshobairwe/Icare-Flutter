import 'package:flutter/material.dart';

class SmsModel extends ChangeNotifier {
  String _smsSent = '';

  set smsSent(String value) {
    _smsSent = value;
    notifyListeners();
  }

  String get smsSent => _smsSent;
}