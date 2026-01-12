import 'package:brasil_fields/brasil_fields.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/domain/providers/dashboard/dashboard_provider_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProviderImpl>();

    return ChangeNotifierProvider.value(
      value: provider,
      child: Container(
        color: ColorsConstants.success,
        height: 150,
        child: Center(
          child: provider.loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      UtilBrasilFields.obterReal(provider.qtdDto.value),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Saldo total',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
