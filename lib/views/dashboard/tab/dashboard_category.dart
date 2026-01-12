import 'package:brasil_fields/brasil_fields.dart';
import 'package:checkplay_mobile/core/components/lists/not_found.dart';
import 'package:checkplay_mobile/core/components/utils/card_custom_image.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/domain/models/dto/dashboard_request.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_category_dto.dart';
import 'package:checkplay_mobile/domain/providers/dashboard/dashboard_provider_impl.dart';
import 'package:checkplay_mobile/views/dashboard/components/month_year_picker.dart';
import 'package:checkplay_mobile/views/dashboard/components/total_balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardCategory extends StatefulWidget {
  const DashboardCategory({super.key});

  @override
  State<DashboardCategory> createState() => _DashboardCategoryState();
}

class _DashboardCategoryState extends State<DashboardCategory> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProviderImpl>();

    Widget getWidget() {
      if (provider.loading) {
        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 2 - 170,
          ),
          child: const CircularProgressIndicator(),
        );
      } else if (provider.listCategories.isEmpty) {
        return const NotFound();
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: provider.listCategories.length,
            itemBuilder: (_, index) {
              QtdCategoryDto dto = provider.listCategories[index];
              return CardCustomImage(
                isCover: true,
                image: dto.image,
                title: dto.name,
                trailing: Text(
                  UtilBrasilFields.obterReal(dto.value),
                  style: const TextStyle(
                    fontSize: 18,
                    color: ColorsConstants.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    return Column(
      children: [
        const TotalBalance(),
        MonthYearPicker(
          initialDate: date,
          borderRadius: BorderRadius.circular(0),
          onChanged: (value) {
            provider.changeRequest(
              DashboardRequest(month: value.month, year: value.year),
            );
            setState(() {
              date = value;
            });
          },
        ),
        getWidget(),
      ],
    );
  }
}
