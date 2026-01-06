import 'package:checkplay_mobile/core/components/forms/buttom_custom.dart';
import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final nameEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = context.read<UserProviderImpl>();
    setState(() {
      nameEC.text = provider.userLogged!.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CircleAvatar(
                    radius: 100,
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputCustom(
                    controller: nameEC,
                    hintText: 'Digite seu nome',
                    label: 'Nome',
                    icon: const Icon(Icons.person),
                    maxLength: 150,
                    validator: Validatorless.required(
                      'Nome é obrigatório',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtomCustom(
                    label: 'Salvar',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
