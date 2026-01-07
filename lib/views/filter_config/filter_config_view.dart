import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/views/filter_config/components/size_component.dart';
import 'package:checkplay_mobile/views/filter_config/components/status_radio_row.dart';
import 'package:flutter/material.dart';

class FilterConfigView extends StatefulWidget {
  const FilterConfigView({super.key});

  @override
  State<FilterConfigView> createState() => _FilterConfigViewState();
}

class _FilterConfigViewState extends State<FilterConfigView> {
  String size = '10';
  String status = CheckplayStatus.ALL;
  Category category = Category.empty();

  CheckplayFilter filter = CheckplayFilter();

  @override
  Widget build(BuildContext context) {
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
                value: status,
                onChanged: (value) {
                  setState(() {
                    status = value;
                  });
                },
              ),
              const Divider(
                height: 50,
              ),
              SizeComponent(
                value: size,
                onChanged: (value) {
                  setState(() {
                    size = value;
                  });
                },
              ),
              const Divider(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
