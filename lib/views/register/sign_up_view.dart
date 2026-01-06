// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/core/components/forms/buttom_custom.dart';
import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  User obj = User.empty();

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    confirmPasswordEC.dispose();
  }

  void register() {
    DialogCustom.dialogLoading(context);
    final provider = context.read<UserProviderImpl>();
    provider.register().then((value) {
      Navigator.pop(context);
      DialogCustom.dialogSuccess(context: context, msg: MsgsCustom.saved);
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouterName.baseRoute,
        (route) => false,
      );
    }).catchError((error) {
      Navigator.pop(context);
      DialogCustom.dialogError(context: context, msg: error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Voltar'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      ImageConstants.logo,
                      width: 220,
                    ),
                  ),
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
                const SizedBox(
                  height: 25,
                ),
                ButtomCustom(
                  label: 'Cadastrar',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      register();
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
