import 'package:checkplay_mobile/core/components/forms/dropdown_custom.dart';
import 'package:checkplay_mobile/core/components/forms/dropdown_search.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/domain/providers/category/category_provider_impl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterIconButton extends StatefulWidget {
  const FilterIconButton({super.key});

  @override
  State<FilterIconButton> createState() => _FilterIconButtonState();
}

class _FilterIconButtonState extends State<FilterIconButton> {
  String size = '10';
  String status = CheckplayStatus.ALL;
  Category category = Category.empty();
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
                        status = value ?? '10';
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
                        dropdownDecoratorProps: getStyle(
                          label: "Categoria",
                          hintText: "Selecione a categoria",
                        ),
                      );
                      // return DropdownCustom(
                      //   label: 'Categoria',
                      //   value: categoryId ?? '',
                      //   onChanged: (value) {
                      //     setState(() {
                      //       categoryId = value;
                      //     });
                      //   },
                      //   items: categories.map<DropdownMenuItem<String>>((e) {
                      //     return DropdownMenuItem<String>(
                      //       value: e.id,
                      //       child: Text(e.name),
                      //     );
                      //   }).toList(),
                      // );
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
                        size = value ?? '10';
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
            onPressed: () {},
          );
        },
        icon: const Icon(Icons.filter_list));
  }
}
