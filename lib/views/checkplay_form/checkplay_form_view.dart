// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:checkplay_mobile/core/components/forms/buttom_custom.dart';
import 'package:checkplay_mobile/core/components/forms/input_custom.dart';
import 'package:checkplay_mobile/core/components/forms/outlined_custom_button.dart';
import 'package:checkplay_mobile/core/components/images/image_container.dart';
import 'package:checkplay_mobile/core/components/search/dropdown_search_custom.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/domain/models/entities/checkplay.dart';
import 'package:checkplay_mobile/domain/providers/category/category_provider_impl.dart';
import 'package:checkplay_mobile/domain/providers/checkplay/checkplay_provider_impl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class CheckplayFormView extends StatefulWidget {
  const CheckplayFormView({super.key});

  @override
  State<CheckplayFormView> createState() => _CheckplayFormViewState();
}

class _CheckplayFormViewState extends State<CheckplayFormView> {
  late String _title;
  dynamic image;
  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Category? category;
  Checkplay obj = Checkplay.empty();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    descriptionEC.dispose();
  }

  void loadData() {
    obj = context.read<CheckplayProviderImpl>().obj;
    String t = "";
    if (obj.id == null) {
      t = "Novo";
    } else {
      t = obj.name;
    }

    setState(() {
      _title = t;
      nameEC.text = obj.name;
      descriptionEC.text = obj.description ?? '';
      image = obj.image;

      if (obj.category.id != null) {
        category = obj.category;
      }
    });
  }

  Future<void> saveImage(XFile? selectedImage) async {
    if (selectedImage != null) {
      DialogCustom.dialogLoading(context);
      context
          .read<CheckplayProviderImpl>()
          .upload(File(selectedImage.path))
          .then((value) {
        Navigator.pop(context);
        setState(() {
          image = selectedImage;
          DialogCustom.dialogSuccess(
              context: context, msg: MsgsCustom.uploadSuccess);
        });
      }).catchError((error) {
        Navigator.pop(context);
        DialogCustom.dialogError(context: context, msg: '$error');
      });
    }
  }

  Future<void> send() async {
    formKey.currentState!.save();
    final provider = context.read<CheckplayProviderImpl>();
    provider.obj = obj;
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
      DialogCustom.dialogError(context: context, msg: '$error');
    });
  }

  changeAction() {
    final provider = context.read<CheckplayProviderImpl>();
    provider.obj = obj;
    DialogCustom.dialogLoading(context);
    provider.changeAction().then((value) {
      Navigator.pop(context);
      DialogCustom.dialogSuccess(
        context: context,
        msg: MsgsCustom.saved,
      );
      setState(() {
        obj.getValueAction();
      });
    }).catchError((error) {
      Navigator.pop(context);
      DialogCustom.dialogError(context: context, msg: '$error');
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InputCustom(
                      controller: nameEC,
                      maxLength: 150,
                      validator: Validatorless.required('Nome é obrigatório'),
                      hintText: 'Digite o nome.',
                      label: 'Nome',
                      onSaved: (value) {
                        obj.name = value!;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Consumer<CategoryProviderImpl>(
                      builder: (_, provider, __) {
                        final list = provider.list;
                        return DropdownSearchCustom(
                          validator: (value) {
                            if (value == null || value.id == null) {
                              return 'Categoria é obrigatória';
                            }
                            return null;
                          },
                          items: list,
                          itemAsString: (item) => item.name,
                          selectedItem: category,
                          onChanged: (value) {
                            setState(() {
                              category = value;
                            });
                          },
                          onSaved: (value) {
                            obj.category = value!;
                          },
                          label: 'Categoria',
                          hintText: 'Selecione a categoria',
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputCustom(
                      controller: descriptionEC,
                      hintText: 'Digite a descrição (OPCIONAL)',
                      label: 'Descrição',
                      onSaved: (value) {
                        obj.description = value!;
                      },
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ButtomCustom(
                      label: 'Salvar',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await send();
                          loadData();
                        }
                      },
                    ),
                    Visibility(
                      visible: obj.id != null,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          OutlinedCustomButton(
                            label: obj.getTextAction(),
                            btnTextColor: obj.getColorAction(),
                            onPressed: () {
                              changeAction();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
