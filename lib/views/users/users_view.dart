// ignore_for_file: use_build_context_synchronously

import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/core/components/lists/not_found.dart';
import 'package:checkplay_mobile/core/components/utils/card_custom_icon.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:checkplay_mobile/views/users/components/user_filter_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    final provider = context.read<UserProviderImpl>();
    provider.search();
  }

  onDelete(String id) {
    final provider = context.read<UserProviderImpl>();
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
    final provider = context.watch<UserProviderImpl>();
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text('Usuários'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: isSearching
                ? const Icon(Icons.close)
                : const Icon(
                    Icons.search,
                  ),
          )
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: isSearching,
            child: const UserFilterComponent(),
          ),
          Expanded(
            child: ChangeNotifierProvider.value(
              value: provider,
              builder: (_, __) {
                if (provider.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.list.isEmpty) {
                  return const NotFound();
                } else {
                  return ListView.builder(
                    itemCount: provider.list.length,
                    itemBuilder: (_, index) {
                      final obj = provider.list[index];
                      return CardCustomIcon(
                        icon: const CircleAvatar(
                          child: Icon(
                            Icons.person,
                          ),
                        ),
                        title: obj.name,
                        subtitle: Text(
                          obj.email,
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: obj.getColorByStatus(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            obj.getTitleByStatus(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onTap: () {
                          provider.obj = obj;
                          Navigator.pushNamed(
                            context,
                            RouterName.userForm,
                          );
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.obj = User.empty();
          Navigator.pushNamed(context, RouterName.userForm);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
