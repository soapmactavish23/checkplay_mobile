import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/components/forms/outlined_custom_button.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFilterComponent extends StatefulWidget {
  const UserFilterComponent({super.key});

  @override
  State<UserFilterComponent> createState() => _UserFilterComponentState();
}

class _UserFilterComponentState extends State<UserFilterComponent> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    emailEC.dispose();
  }

  loadData() {
    final provider = context.read<UserProviderImpl>();
    setState(() {
      nameEC.text = provider.filter.name;
      emailEC.text = provider.filter.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProviderImpl>();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            InputCustom(
              controller: nameEC,
              label: 'Nome',
              hintText: 'Digite o nome',
              icon: const Icon(Icons.badge),
              onSaved: (value) {
                provider.filter.name = value ?? '';
              },
            ),
            const SizedBox(
              height: 15,
            ),
            InputCustom(
              controller: emailEC,
              label: 'E-mail',
              hintText: 'Digite o e-mail',
              icon: const Icon(Icons.email),
              onSaved: (value) {
                provider.filter.email = value ?? '';
              },
            ),
            const SizedBox(
              height: 15,
            ),
            OutlinedCustomButton(
              label: 'Pesquisar',
              btnTextColor: ColorsConstants.defaultColor,
              onPressed: () {
                formKey.currentState!.save();
                provider.search();
              },
            ),
            const Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
