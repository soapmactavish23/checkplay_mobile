import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';

class SizeComponent extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  const SizeComponent({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Quantidade:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(width: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _sizeItem('10'),
              _sizeItem('50'),
              _sizeItem('100'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sizeItem(String size) {
    final bool selected = value == size;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => onChanged(size),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? ColorsConstants.primary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? ColorsConstants.primary : Colors.grey.shade400,
              width: 1.4,
            ),
          ),
          child: Text(
            size,
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
