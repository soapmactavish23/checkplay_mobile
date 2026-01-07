import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/routes/router_name.dart';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:flutter/material.dart';

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
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
    );
  }
}
