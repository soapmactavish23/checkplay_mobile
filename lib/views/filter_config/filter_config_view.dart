// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/domain/providers/checkplay/checkplay_provider_impl.dart';
import 'package:checkplay_mobile/views/filter_config/components/category_component.dart';
import 'package:checkplay_mobile/views/filter_config/components/size_component.dart';
import 'package:checkplay_mobile/views/filter_config/components/status_radio_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterConfigView extends StatefulWidget {
  const FilterConfigView({super.key});

  @override
  State<FilterConfigView> createState() => _FilterConfigViewState();
}

class _FilterConfigViewState extends State<FilterConfigView> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckplayProviderImpl>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar Filtro'),
        actions: [
          IconButton(
            onPressed: () {
              DialogCustom.dialogLoading(context);
              provider.search().then(
                (value) {
                  Navigator.pop(context);
                  DialogCustom.dialogSuccess(
                    context: context,
                    msg: 'Lista recarregada com sucesso!',
                  );
                },
              ).catchError((error) {
                Navigator.pop(context);
                DialogCustom.dialogError(
                  context: context,
                  msg: '$error',
                );
              });
            },
            icon: const Icon(Icons.replay),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            children: [
              StatusRadioRow(
                value: provider.filter.status,
                onChanged: (value) {
                  setState(() {
                    provider.filter.status = value;
                  });
                },
              ),
              const Divider(
                height: 50,
              ),
              SizeComponent(
                value: provider.filter.size.toString(),
                onChanged: (value) {
                  setState(() {
                    provider.filter.size = int.parse(value);
                  });
                },
              ),
              const Divider(
                height: 50,
              ),
              CategoryComponent(
                value: provider.filter.categoryId,
                onChanged: (value, image) {
                  setState(() {
                    provider.filter.categoryId = value;
                    provider.filter.imageCategory =
                        image ?? ImageConstants.logo;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
