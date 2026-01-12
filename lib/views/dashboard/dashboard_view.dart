import 'package:brasil_fields/brasil_fields.dart';
import 'package:checkplay_mobile/core/components/utils/card_custom_image.dart';
import 'package:checkplay_mobile/domain/models/dto/check_qtd_dto.dart';
import 'package:checkplay_mobile/views/base/components/drawer_custom.dart';
import 'package:checkplay_mobile/views/dashboard/components/month_year_picker.dart';
import 'package:checkplay_mobile/views/dashboard/components/total_balance.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DateTime date = DateTime.now();

  List<CheckQtdDto> list = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      list = [
        CheckQtdDto(
          id: '1',
          name: 'Do Mil ao Milhão sem cortar o cafezinho',
          value: 10.00,
          categoryName: 'Livros',
          image:
              'https://checkplay.s3.amazonaws.com/fotos/%2Fcheckplay/ab768c45-9998-4f60-b3cd-e5e4f02fb60d/0ad4cfb2-ccdf-44dd-85d6-866c3a305dac',
        ),
        CheckQtdDto(
          id: '1',
          name: 'Do Mil ao Milhão sem cortar o cafezinho',
          value: 10.00,
          categoryName: 'Livros',
          image:
              'https://checkplay.s3.amazonaws.com/fotos/%2Fcheckplay/ab768c45-9998-4f60-b3cd-e5e4f02fb60d/0ad4cfb2-ccdf-44dd-85d6-866c3a305dac',
        ),
        CheckQtdDto(
          id: '1',
          name: 'Do Mil ao Milhão sem cortar o cafezinho',
          value: 10.00,
          categoryName: 'Livros',
          image:
              'https://checkplay.s3.amazonaws.com/fotos/%2Fcheckplay/ab768c45-9998-4f60-b3cd-e5e4f02fb60d/0ad4cfb2-ccdf-44dd-85d6-866c3a305dac',
        ),
        CheckQtdDto(
          id: '1',
          name: 'Do Mil ao Milhão sem cortar o cafezinho',
          value: 10.00,
          categoryName: 'Livros',
          image:
              'https://checkplay.s3.amazonaws.com/fotos/%2Fcheckplay/ab768c45-9998-4f60-b3cd-e5e4f02fb60d/0ad4cfb2-ccdf-44dd-85d6-866c3a305dac',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          const TotalBalance(),
          MonthYearPicker(
            initialDate: date,
            borderRadius: BorderRadius.circular(0),
            onChanged: (value) {
              setState(() {
                date = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                CheckQtdDto dto = list[index];
                return CardCustomImage(
                  title: dto.name,
                  subtitle: Text(
                    UtilBrasilFields.obterReal(dto.value),
                  ),
                  image: dto.image,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
