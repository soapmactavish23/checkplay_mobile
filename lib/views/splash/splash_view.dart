// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _scale = 4.0;
  double _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 350 * _scale;
  double get _logoAnimationHeight => 350 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
    super.initState();
  }

  Future<void> isUserLogged() async {
    final provider = context.read<UserProviderImpl>();
    if (provider.userLogged != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouterName.baseRoute,
        (_) => false,
      );
    } else {
      Navigator.of(context).pushNamed(RouterName.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _animationOpacityLogo,
          duration: const Duration(seconds: 3),
          onEnd: () {},
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),
            width: _logoAnimationWidth,
            height: _logoAnimationHeight,
            curve: Curves.linearToEaseOut,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  ImageConstants.logo,
                ),
              ],
            ),
            onEnd: () async {
              isUserLogged();
            },
          ),
        ),
      ),
    );
  }
}
