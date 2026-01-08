// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/components/lists/not_found.dart';
import 'package:checkplay_mobile/core/components/search/icon_search.dart';
import 'package:checkplay_mobile/core/components/utils/card_custom.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/provider/group/group_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    context.read<GroupProviderImpl>().findAll();
  }

  onDelete(String id) {
    final provider = context.read<GroupProviderImpl>();
    provider.obj.id = id;
    provider.delete().then((value) {
      DialogCustom.dialogSuccess(
        context: context,
        msg: MsgsCustom.deleted,
      );
    }).catchError((error) {
      DialogCustom.dialogError(context: context, msg: '$error');
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GroupProviderImpl>();
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text('Grupos'),
        actions: [
          IconSearch.search(
            context: context,
            onSearch: (value) {
              provider.search(value);
            },
          ),
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
                final obj = provider.listFiltered[index];
                return CardCustom(
                  title: obj.name,
                  onTap: () {
                    provider.obj = obj;
                    // Navigator.pushNamed(context, RouterName.categoryForm);
                  },
                  onLongPress: () {
                    DialogCustom.dialogConfirm(
                      context: context,
                      msg: MsgsCustom.confirmationDelete,
                      onPressed: () async {
                        onDelete(obj.id!);
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
