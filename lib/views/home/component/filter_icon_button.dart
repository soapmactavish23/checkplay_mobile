// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:checkplay_mobile/core/components/forms/dropdown_custom.dart';
import 'package:checkplay_mobile/core/components/forms/dropdown_search.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/domain/providers/category/category_provider_impl.dart';

class FilterIconButton extends StatefulWidget {
  final Function(CheckplayFilter filter) onSelected;

  const FilterIconButton({
    super.key,
    required this.onSelected,
  });

  @override
  State<FilterIconButton> createState() => _FilterIconButtonState();
}

class _FilterIconButtonState extends State<FilterIconButton> {
  String size = '10';
  String status = CheckplayStatus.ALL;
  Category category = Category.empty();

  CheckplayFilter filter = CheckplayFilter();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          DialogCustom.dialogComponent(
            context: context,
            title: 'Filtro',
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownCustom(
                    label: 'Status',
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        filter.status = value ?? '10';
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: CheckplayStatus.ALL,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          color: ColorsConstants.primary,
                          child: const Text(
                            CheckplayStatus.TODOS,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: CheckplayStatus.PENDING,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          color: ColorsConstants.danger,
                          child: const Text(
                            CheckplayStatus.PENDENTE,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: CheckplayStatus.PROGRESS,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          color: ColorsConstants.info,
                          child: const Text(
                            CheckplayStatus.EM_ANDAMENTO,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: CheckplayStatus.FINISH,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          color: ColorsConstants.success,
                          child: const Text(
                            CheckplayStatus.FINALIZADO,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<CategoryProviderImpl>(
                    builder: (_, providerCategory, __) {
                      final categories = providerCategory.list;
                      return DropdownSearch<Category>(
                        items: categories,
                        itemAsString: ((item) => item.name),
                        clearButtonProps: const ClearButtonProps(
                          icon: Icon(Icons.clear),
                        ),
                        selectedItem: category,
                        onChanged: (value) {
                          if (value != null) {
                            filter.categoryId = value.id ?? '';
                            filter.imageCategory = value.image ?? '';
                          }
                        },
                        dropdownDecoratorProps: getStyle(
                          label: "Categoria",
                          hintText: "Selecione a categoria",
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownCustom(
                    label: 'Quantidade',
                    value: size,
                    onChanged: (value) {
                      setState(() {
                        filter.size = int.parse(value ?? '10');
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: '10',
                        child: Text('10'),
                      ),
                      DropdownMenuItem(
                        value: '50',
                        child: Text('50'),
                      ),
                      DropdownMenuItem(
                        value: '100',
                        child: Text('100'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            textConfirm: 'Pesquisar',
            onPressed: () {
              widget.onSelected(filter);
            },
          );
        },
        icon: const Icon(Icons.filter_list));
  }
}
