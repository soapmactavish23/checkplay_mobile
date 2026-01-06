// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/components/forms/buttom_custom.dart';
import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/components/forms/link_text.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool remember = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await isUserLogged();
    });
    getRemember();
    _passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    loginEC.dispose();
    passwordEC.dispose();
  }

  Future<void> isUserLogged() async {
    final provider = context.read<UserProviderImpl>();
    if (provider.userLogged != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouterName.baseRoute,
        (_) => false,
      );
    }
  }

  Future<void> getRemember() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEC.text = prefs.getString("email") ?? '';
      passwordEC.text = prefs.getString("password") ?? '';
    });
  }

  Future<void> checkRemember(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (remember) {
      prefs.setString("email", email);
      prefs.setString("password", password);
    } else {
      prefs.setString("email", '');
      prefs.setString("password", '');
    }
  }

  Future<void> signIn() async {
    final String email = loginEC.text;
    final String password = passwordEC.text;
    final provider = context.read<UserProviderImpl>();

    await checkRemember(email, password);

    provider.signIn(email, password).then((value) {
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouterName.baseRoute,
        (route) => false,
      );
    }).catchError((err) {
      Navigator.pop(context);
      DialogCustom.dialogError(context: context, msg: err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
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
                  const SizedBox(
                    height: 35,
                  ),
                  InputCustom(
                    controller: loginEC,
                    icon: const Icon(Icons.email),
                    maxLength: 150,
                    validator: Validatorless.multiple([
                      Validatorless.email('E-mail inválido'),
                      Validatorless.required('E-mail é obrigatório')
                    ]),
                    label: 'E-mail',
                    hintText: 'Digite seu e-mail',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputCustom(
                    controller: passwordEC,
                    icon: const Icon(Icons.lock),
                    maxLength: 150,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha é obrigatória'),
                      Validatorless.min(
                          6, 'Senha deve ter no mínimo 6 caracteres')
                    ]),
                    label: 'Senha',
                    hintText: 'Digite sua senha',
                    obscureText: _passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: ColorsConstants.secondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtomCustom(
                    label: 'Entrar',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        DialogCustom.dialogLoading(context);
                        signIn();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: remember,
                        onChanged: (bool? value) {
                          setState(() {
                            remember = value!;
                          });
                        },
                      ),
                      InkWell(
                        child: const Text('Lembrar senha'),
                        onTap: () {
                          setState(() {
                            remember = !remember;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LinkText(
                    text: 'Não tem conta? Cadastre-se',
                    onPressed: () {
                      Navigator.pushNamed(context, RouterName.signUpRoute);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
