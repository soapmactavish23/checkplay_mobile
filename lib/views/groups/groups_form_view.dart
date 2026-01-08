// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/auth/models/group.dart';
import 'package:checkplay_mobile/core/components/forms/buttom_custom.dart';
import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/provider/group/group_provider_impl.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class GroupsFormView extends StatefulWidget {
  const GroupsFormView({super.key});

  @override
  State<GroupsFormView> createState() => _GroupsFormViewState();
}

class _GroupsFormViewState extends State<GroupsFormView> {
  late String _title;
  final nameEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Group obj = Group.empty();

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
    obj = context.read<GroupProviderImpl>().obj;
    String t = "";
    if (obj.id == null) {
      t = "Novo grupo";
    } else {
      t = obj.name;
    }
    setState(() {
      _title = t;
      nameEC.text = obj.name;
    });
  }

  Future<void> send() async {
    formKey.currentState!.save();
    final provider = context.read<GroupProviderImpl>();
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
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Image.asset(ImageConstants.groups),
                    InputCustom(
                      controller: nameEC,
                      maxLength: 150,
                      validator: Validatorless.required('Nome é obrigatório'),
                      hintText: 'Digite o nome da categoria',
                      label: 'Nome',
                      onSaved: (value) {
                        obj.name = value!;
                        setState(() {
                          _title = value;
                        });
                      },
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
