import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/views/base/base_view.dart';
import 'package:checkplay_mobile/views/splash/splash_view.dart';

class Routes {
  static Route<dynamic> onGenereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.baseRoute:
        return MaterialPageRoute(builder: (_) => const BaseView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
