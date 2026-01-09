// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/auth/models/group.dart';
import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/core/components/forms/buttom_custom.dart';
import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/components/search/dropdown_search_custom.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/provider/group/group_provider_impl.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class UsersFormView extends StatefulWidget {
  const UsersFormView({super.key});

  @override
  State<UsersFormView> createState() => _UsersFormViewState();
}

class _UsersFormViewState extends State<UsersFormView> {
  late String _title;
  dynamic image;
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  User obj = User.empty();
  Group? group;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
  }

  void loadData() {
    obj = context.read<UserProviderImpl>().obj;
    setState(() {
      if (obj.id == null) {
        _title = "Novo usuário";
        group = null;
      } else {
        _title = obj.name;
        group = obj.group;
      }
      nameEC.text = obj.name;
      emailEC.text = obj.email;
    });
  }

  Future<void> send() async {
    formKey.currentState!.save();
    final provider = context.read<UserProviderImpl>();
    DialogCustom.dialogLoading(context);
    provider.save().then((value) {
      Navigator.pop(context);
      DialogCustom.dialogSuccess(
        context: context,
        msg: MsgsCustom.saved,
      );
      Navigator.pop(context);
    }).catchError((error) {
      Navigator.pop(context);
      DialogCustom.dialogError(context: context, msg: error);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(
                  radius: 100,
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
                const Divider(
                  height: 30,
                ),
                InputCustom(
                  controller: nameEC,
                  icon: const Icon(Icons.person),
                  hintText: 'Digite seu nome',
                  label: 'Nome',
                  maxLength: 150,
                  validator: Validatorless.required('Nome é obrigatório'),
                  onSaved: (value) => obj.name = value!,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputCustom(
                  controller: emailEC,
                  icon: const Icon(Icons.email),
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Digite seu e-mail',
                  label: 'E-mail',
                  maxLength: 150,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail é obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  onSaved: (value) => obj.email = value!,
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<GroupProviderImpl>(
                  builder: (_, provider, __) {
                    final list = provider.list;

                    return DropdownSearchCustom(
                      label: 'Grupo',
                      hintText: 'Selecione o grupo',
                      validator: (value) {
                        if (value == null || value.id == null) {
                          return 'Grupo é obrigatório';
                        }
                        return null;
                      },
                      labelTextSearch: 'Pesquisar',
                      hintTextSearch: 'Digite a busca',
                      items: list,
                      itemAsString: (item) => item.name,
                      selectedItem: group,
                      onChanged: (value) {
                        setState(() {
                          group = value;
                        });
                      },
                      onSaved: (value) {
                        obj.group = value!;
                      },
                    );
                  },
                ),
                Visibility(
                  visible: obj.id == null,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      InputCustom(
                        controller: passwordEC,
                        icon: const Icon(Icons.lock),
                        hintText: 'Digite sua senha',
                        label: 'Senha',
                        obscureText: true,
                        maxLength: 150,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha é obrigatório'),
                          Validatorless.min(
                            6,
                            'Senha deve ter no mínimo 6 caracteres',
                          ),
                        ]),
                        onSaved: (value) => obj.password = value,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputCustom(
                        controller: confirmPasswordEC,
                        icon: const Icon(Icons.lock_outline),
                        hintText: 'Confirme sua senha',
                        label: 'Confirmar Senha',
                        obscureText: true,
                        maxLength: 150,
                        validator: Validatorless.compare(
                          passwordEC,
                          'As senhas devem ser iguais',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtomCustom(
                  label: MsgsCustom.save,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      send();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
