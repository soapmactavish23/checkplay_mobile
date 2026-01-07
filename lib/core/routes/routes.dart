import 'package:checkplay_mobile/views/category/category_form_view.dart';
import 'package:checkplay_mobile/views/filter_config/filter_config_view.dart';
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
      case RouterName.categoryForm:
        return MaterialPageRoute(builder: (_) => const CategoryFormView());
      case RouterName.filterConfig:
        return MaterialPageRoute(builder: (_) => const FilterConfigView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
