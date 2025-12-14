import 'package:flutter/material.dart';

class MainNavGlobalKey {
  static MainNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();

  // Avoid self instance
  MainNavGlobalKey._();

  static MainNavGlobalKey get instance => _instance ??= MainNavGlobalKey._();
}
