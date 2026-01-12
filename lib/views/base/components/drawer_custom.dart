import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/domain/providers/core/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProviderImpl>();

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Image.asset(
                      ImageConstants.logo,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    context.read<PageManager>().setPage(PageManager.homeClient);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Dashboard'),
                  onTap: () {
                    context.read<PageManager>().setPage(PageManager.dashboard);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Categorias'),
                  onTap: () {
                    context
                        .read<PageManager>()
                        .setPage(PageManager.categoryClient);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Perfil'),
                  onTap: () {
                    context.read<PageManager>().setPage(PageManager.profile);
                  },
                ),
                Visibility(
                  visible: provider.isAdmin(),
                  child: ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Usuários'),
                    onTap: () {
                      context.read<PageManager>().setPage(PageManager.users);
                    },
                  ),
                ),
                Visibility(
                  visible: provider.isAdmin(),
                  child: ListTile(
                    leading: const Icon(Icons.group_outlined),
                    title: const Text('Grupos'),
                    onTap: () {
                      context.read<PageManager>().setPage(PageManager.groups);
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Sair'),
                  onTap: () {
                    final provider = context.read<UserProviderImpl>();
                    provider.signOut();
                    Navigator.of(context).pushNamed(RouterName.loginRoute);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
