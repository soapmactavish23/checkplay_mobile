// ignore_for_file: use_build_context_synchronously
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
abstract class AppBarCustom extends AppBar {
  AppBarCustom({super.key});

  static getDefaultExitOnly({
    required String title,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    return AppBar(
      elevation: 0,
      title: Text(
        title,
      ),
      actions: [
        // IconButton(
        //   onPressed: () async {
        //      Navigator.of(context).pushNamed(RoutesNames.historyRoute);
        //   },
        //   icon: const Icon(
        //     Icons.search,
        //     color: Colors.white,
        //   ),
        // ),
        IconButton(
          onPressed: () async {
            final provider = context.read<UserProviderImpl>();
            provider
                .signOut()
                .then(
                  (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                    RouterName.loginRoute,
                    (route) => false,
                  ),
                )
                .catchError(
                  (err) => DialogCustom.dialogError(context: context, msg: err),
                );
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static getDefault({
    required String title,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    return AppBar(
      title: Text(
        title,
      ),
      actions: [
        ...actions ?? [],
        IconButton(
          onPressed: () => {
            Navigator.pushNamed(
              context,
              RouterName.profileRoute,
            )
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () async {
            final provider = context.read<UserProviderImpl>();
            provider
                .signOut()
                .then(
                  (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                    RouterName.loginRoute,
                    (route) => false,
                  ),
                )
                .catchError(
                  (err) => DialogCustom.dialogError(context: context, msg: err),
                );
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
