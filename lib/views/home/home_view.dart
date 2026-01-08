// ignore_for_file: use_build_context_synchronously
import 'package:checkplay_mobile/core/components/lists/not_found.dart';
import 'package:checkplay_mobile/core/components/search/icon_search.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:checkplay_mobile/domain/models/entities/checkplay.dart';
import 'package:checkplay_mobile/domain/providers/checkplay/checkplay_provider_impl.dart';
import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:checkplay_mobile/views/home/component/card_main.dart';
import 'package:checkplay_mobile/views/home/component/filter_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    final provider = context.read<CheckplayProviderImpl>();
    provider.search();
  }

  onDelete(String id) {
    final provider = context.read<CheckplayProviderImpl>();
    provider.remove(id).then((value) {
      DialogCustom.dialogSuccess(
        context: context,
        msg: MsgsCustom.deleted,
      );
    }).catchError((error) {
      Navigator.pop(context);
      DialogCustom.dialogError(context: context, msg: '$error');
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckplayProviderImpl>();

    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Checkplay'),
        actions: [
          IconSearch.search(
            context: context,
            onSearch: (value) {
              provider.filter.query = value;
              provider.search();
            },
          ),
          IconButton(
            onPressed: () async {
              DialogCustom.dialogConfirm(
                context: context,
                msg: 'Tem certeza que deseja sair?',
                onPressed: () async {
                  await context.read<UserProviderImpl>().signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouterName.splashScreen,
                    (route) => false,
                  );
                },
              );
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const FilterHeader(),
          const Divider(),
          ChangeNotifierProvider.value(
            value: provider,
            builder: (context, _) {
              if (provider.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.list.isEmpty) {
                return const NotFound();
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemCount: provider.list.length,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final obj = provider.list[index];
                        return CardMain(
                          title: obj.name,
                          image: obj.image,
                          categoryImage: obj.category.image,
                          colorStatus: CheckplayStatus.getColorByStatus(
                            obj.status,
                          ),
                          onTap: () {
                            provider.obj = obj;
                            Navigator.of(context).pushNamed(
                              RouterName.checkplayForm,
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
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.obj = Checkplay.empty();
          Navigator.of(context).pushNamed(
            RouterName.checkplayForm,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
