// ignore_for_file: use_build_context_synchronously
import 'package:checkplay_mobile/core/components/images/image_custom.dart';
import 'package:checkplay_mobile/core/components/lists/not_found.dart';
import 'package:checkplay_mobile/core/components/search/icon_search.dart';
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/provider/user/user_provider_impl.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/core/utils/msgs_custom.dart';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';
import 'package:checkplay_mobile/domain/providers/checkplay/checkplay_provider_impl.dart';
import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:checkplay_mobile/views/home/component/card_main.dart';
import 'package:checkplay_mobile/views/home/component/filter_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CheckplayFilter filter = CheckplayFilter();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    final provider = context.read<CheckplayProviderImpl>();
    provider.search(filter);
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
              filter.query = value;
              provider.search(filter);
            },
          ),
          FilterIconButton(
            onSelected: (filterSelected) {
              filter.setFilter(filterSelected);
              provider.search(filter);
              Navigator.pop(context);
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
      body: ChangeNotifierProvider.value(
        value: provider,
        builder: (context, _) {
          if (provider.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.list.isEmpty) {
            return const NotFound();
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Filtros:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: ColorsConstants.defaultColor,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                color: ColorsConstants.danger,
                                child: const Text(
                                  CheckplayStatus.PENDENTE,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            Image.asset(
                              ImageConstants.logo,
                              width: 50,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
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
                        colorStatus: obj.getColorByStatus(),
                        onTap: () {
                          provider.obj = obj;
                          // Navigator.of(context).pushNamed(
                          //   RouterName.accountRoute,
                          // );
                        },
                        onLongPress: () {
                          DialogCustom.dialogConfirm(
                            context: context,
                            msg: MsgsCustom.confirmationDelete,
                            onPressed: () async {
                              provider.obj = obj;
                              try {
                                await provider.remove(obj.id!);
                                if (mounted) {
                                  DialogCustom.dialogSuccess(
                                    context: context,
                                    msg: MsgsCustom.deleted,
                                  );
                                  Navigator.of(context).pop();
                                }
                              } catch (err) {
                                if (mounted) {
                                  Navigator.of(context).pop();
                                  DialogCustom.dialogError(
                                    context: context,
                                    msg: '$err',
                                  );
                                }
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
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
