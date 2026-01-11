// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:checkplay_mobile/core/components/forms/buttom_custom.dart';
import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/components/images/image_container.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/domain/providers/category/category_provider_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class CategoryFormView extends StatefulWidget {
  const CategoryFormView({super.key});

  @override
  State<CategoryFormView> createState() => _CategoryFormViewState();
}

class _CategoryFormViewState extends State<CategoryFormView> {
  late String _title;
  dynamic image;
  final nameEC = TextEditingController();
  final valueEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Category obj = Category.empty();

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
    obj = context.read<CategoryProviderImpl>().obj;
    String t = "";
    if (obj.id == null) {
      t = "Nova categoria";
    } else {
      t = obj.name;
    }
    setState(() {
      _title = t;
      nameEC.text = obj.name;
      valueEC.text = '${obj.value}';
      image = obj.image;
    });
  }

  Future<void> saveImage(XFile? selectedImage) async {
    if (selectedImage != null) {
      DialogCustom.dialogLoading(context);
      context
          .read<CategoryProviderImpl>()
          .uploadImage(File(selectedImage.path))
          .then((value) {
        setState(() {
          Navigator.pop(context);
          image = selectedImage;
          DialogCustom.dialogSuccess(
              context: context, msg: MsgsCustom.uploadSuccess);
        });
      }).catchError((error) {
        Navigator.pop(context);
        DialogCustom.dialogError(context: context, msg: error);
      });
    }
  }

  Future<void> send() async {
    formKey.currentState!.save();
    final provider = context.read<CategoryProviderImpl>();
    DialogCustom.dialogLoading(context);
    provider.save().then((value) {
      Navigator.pop(context);
      DialogCustom.dialogSuccess(
        context: context,
        msg: MsgsCustom.saved,
      );
      loadData();
    }).catchError((error) {
      Navigator.pop(context);
      DialogCustom.dialogError(context: context, msg: error);
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
            child: Column(
              children: [
                ImageContainer(
                  image: image,
                  saveImage: saveImage,
                  disabled: obj.id == null,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
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
                        height: 15,
                      ),
                      InputCustom(
                        controller: valueEC,
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(moeda: true)
                        ],
                        maxLength: 150,
                        validator:
                            Validatorless.required('Valor é obrigatório'),
                        hintText: 'Digite o valor da categoria',
                        label: 'Valor',
                        icon: const Icon(Icons.currency_exchange),
                        onSaved: (value) {
                          value = value!.replaceAll('R\$ ', '');

                          obj.value = double.parse(value);
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
                ),
              ],
            ),
          ),
        ));
  }
}
