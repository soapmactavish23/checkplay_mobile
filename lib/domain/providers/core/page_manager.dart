import 'dart:developer';

import 'package:flutter/material.dart';

class PageManager {
  final PageController _pageController;

  PageManager(this._pageController);

  int page = 0;

  static int homeClient = 0;
  static int categoryClient = 1;
  static int profile = 2;
  static int users = 3;
  static int groups = 4;
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
