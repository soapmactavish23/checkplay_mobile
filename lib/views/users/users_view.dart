import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:flutter/material.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: Container(),
    );
  }
}
