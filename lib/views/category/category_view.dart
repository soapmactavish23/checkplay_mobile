import 'package:checkplay_mobile/core/components/lists/not_found.dart';
import 'package:checkplay_mobile/core/components/search/icon_search.dart';
import 'package:checkplay_mobile/core/components/utils/card_custom_image.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/domain/providers/category/category_provider_impl.dart';
import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    context.read<CategoryProviderImpl>().findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProviderImpl>();
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text('Categorias'),
        actions: [
          IconSearch.search(
            context: context,
            onSearch: (value) {
              provider.search(value);
            },
          )
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: provider,
        builder: (_, __) {
          if (provider.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.listFiltered.isEmpty) {
            return const NotFound();
          } else {
            return ListView.builder(
              itemCount: provider.listFiltered.length,
              itemBuilder: (_, index) {
                Category obj = provider.listFiltered[index];
                return CardCustomImage(
                  image: obj.image,
                  title: obj.name,
                  onTap: () {
                    provider.obj = obj;
                    Navigator.pushNamed(context, RouterName.categoryForm);
                  },
                  onLongPress: () {
                    DialogCustom.dialogConfirm(
                      context: context,
                      msg: MsgsCustom.confirmationDelete,
                      onPressed: () {
                        provider.remove(obj.id!);
                        DialogCustom.dialogSuccess(
                            context: context, msg: MsgsCustom.deleted);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.obj = Category.empty();
          Navigator.pushNamed(context, RouterName.categoryForm);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
