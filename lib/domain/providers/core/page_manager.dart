import 'dart:developer';

import 'package:flutter/material.dart';

class PageManager {
  final PageController _pageController;

  PageManager(this._pageController);

  int page = 0;

  // Client Views
  static int homeClient = 0;
  static int scannerClient = 1;
  static int categoryClient = 2;

  // Admin Views
  static int login = 3;
  static int animalAdmin = 0;
  static int categoryAdmin = 1;
  static int userAdmin = 2;
  static int groupAdmin = 3;

  void setPage(int value) {
    try {
      if (value == page) return;
      page = value;
      _pageController.jumpToPage(value);
    } catch (e, s) {
      log('Error: $e', error: e, stackTrace: s);
    }
  }
}
