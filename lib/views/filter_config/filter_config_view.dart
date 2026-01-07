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
  // CheckplayFilter filter = CheckplayFilter();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckplayProviderImpl>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar Filtro'),
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
                onChanged: (value) {
                  setState(() {
                    provider.filter.categoryId = value;
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
