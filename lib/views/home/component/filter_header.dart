import 'package:checkplay_mobile/core/components/images/image_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:checkplay_mobile/domain/providers/checkplay/checkplay_provider_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouterName.filterConfig);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.filter_list,
                  size: 24,
                  color: ColorsConstants.defaultColor,
                )
              ],
            ),
            Consumer<CheckplayProviderImpl>(
              builder: (_, provider, __) {
                final status = provider.filter.status;
                final image = provider.filter.imageCategory;
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //TODO QUERO DEIXAR ESSE CONTAINER COM AS BORDAS ARREDONDADAS
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: CheckplayStatus.getColorByStatus(status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            CheckplayStatus.getTitleByStatus(status),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      ImageCustom.getImageWidget(image, width: 50, height: 50),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
