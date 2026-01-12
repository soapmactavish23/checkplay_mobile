import 'package:checkplay_mobile/domain/providers/category/category_provider_impl.dart';
import 'package:checkplay_mobile/domain/providers/checkplay/checkplay_provider_impl.dart';
import 'package:checkplay_mobile/domain/providers/dashboard/dashboard_provider_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checkplay_mobile/core/provider/group/group_provider_impl.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';

class ApplicationProvider extends StatelessWidget {
  final Widget materialApp;
  const ApplicationProvider({super.key, required this.materialApp});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProviderImpl(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserProviderImpl, GroupProviderImpl>(
          create: (_) => GroupProviderImpl(),
          lazy: false,
          update: (_, objDad, objChild) => objChild!
            ..updateUser(
              objDad.userLogged,
            ),
        ),
        ChangeNotifierProxyProvider<UserProviderImpl, CategoryProviderImpl>(
          create: (_) => CategoryProviderImpl(),
          lazy: false,
          update: (_, objDad, objChild) => objChild!
            ..updateUser(
              objDad.userLogged,
            ),
        ),
        ChangeNotifierProxyProvider<UserProviderImpl, CheckplayProviderImpl>(
          create: (_) => CheckplayProviderImpl(),
          lazy: false,
          update: (_, objDad, objChild) => objChild!
            ..updateUser(
              objDad.userLogged,
            ),
        ),
        ChangeNotifierProvider<DashboardProviderImpl>(
          create: (_) => DashboardProviderImpl(),
          lazy: true,
        ),
      ],
      child: materialApp,
    );
  }
}
