import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';

class StatusRadioRow extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  const StatusRadioRow({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status: ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _statusItem(CheckplayStatus.ALL, CheckplayStatus.TODOS,
                  ColorsConstants.primary),
              _statusItem(CheckplayStatus.PENDING, CheckplayStatus.PENDENTE,
                  ColorsConstants.danger),
              _statusItem(CheckplayStatus.PROGRESS,
                  CheckplayStatus.EM_ANDAMENTO, ColorsConstants.info),
              _statusItem(CheckplayStatus.FINISH, CheckplayStatus.FINALIZADO,
                  ColorsConstants.success),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _statusItem(String status, String label, Color color) {
    final bool selected = value == status;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => onChanged(status),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? color : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? color : Colors.grey.shade400,
              width: 1.4,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
