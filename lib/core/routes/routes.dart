import 'package:checkplay_mobile/views/login/login_view.dart';
import 'package:checkplay_mobile/views/register/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/views/base/base_view.dart';
import 'package:checkplay_mobile/views/splash/splash_view.dart';

class Routes {
  static Route<dynamic> onGenereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.baseRoute:
        return MaterialPageRoute(builder: (_) => BaseView());
      case RouterName.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouterName.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
