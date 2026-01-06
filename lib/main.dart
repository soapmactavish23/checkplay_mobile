import 'package:checkplay_mobile/core/application_config.dart';
import 'package:checkplay_mobile/core/provider/application_provider.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/core/routes/routes.dart';
import 'package:checkplay_mobile/core/ui/main_nav_global_key.dart';
import 'package:checkplay_mobile/core/ui/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationConfig().configureApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationProvider(
      materialApp: MaterialApp(
        title: 'Checkplay',
        debugShowCheckedModeBanner: false,
        navigatorKey: MainNavGlobalKey.instance.navKey,
        theme: MainTheme.themeData,
        initialRoute: RouterName.splashScreen,
        onGenerateRoute: Routes.onGenereteRoute,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
      ),
    );
  }
}
