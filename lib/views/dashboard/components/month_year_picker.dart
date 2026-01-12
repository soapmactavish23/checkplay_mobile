import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearPicker extends StatefulWidget {
  /// Data inicial que define o mês/ano exibidos.
  final DateTime initialDate;

  /// Callback sempre que mudar mês/ano.
  final ValueChanged<DateTime> onChanged;

  /// Opcional: limitar navegação
  final DateTime? minDate;
  final DateTime? maxDate;

  /// Estilo
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final IconData leftIcon;
  final IconData rightIcon;
  final Color? iconColor;

  const MonthYearPicker(
      {super.key,
      required this.initialDate,
      required this.onChanged,
      this.minDate,
      this.maxDate,
      this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      this.borderRadius = const BorderRadius.all(Radius.circular(12)),
      this.backgroundColor = ColorsConstants.success,
      this.textStyle = const TextStyle(color: Colors.white),
      this.leftIcon = Icons.chevron_left,
      this.rightIcon = Icons.chevron_right,
      this.iconColor = Colors.black});

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  late DateTime _current;

  @override
  void initState() {
    super.initState();
    _current = DateTime(widget.initialDate.year, widget.initialDate.month, 1);
  }

  @override
  void didUpdateWidget(covariant MonthYearPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Se o pai trocar a initialDate, atualiza o estado interno.
    if (oldWidget.initialDate.year != widget.initialDate.year ||
        oldWidget.initialDate.month != widget.initialDate.month) {
      _current = DateTime(widget.initialDate.year, widget.initialDate.month, 1);
    }
  }

  bool _isBeforeMin(DateTime value) {
    if (widget.minDate == null) return false;
    final min = DateTime(widget.minDate!.year, widget.minDate!.month, 1);
    return value.isBefore(min);
  }

  bool _isAfterMax(DateTime value) {
    if (widget.maxDate == null) return false;
    final max = DateTime(widget.maxDate!.year, widget.maxDate!.month, 1);
    return value.isAfter(max);
  }

  void _changeMonth(int delta) {
    final next = DateTime(_current.year, _current.month + delta, 1);

    if (_isBeforeMin(next) || _isAfterMax(next)) return;

    setState(() => _current = next);
    widget.onChanged(_current); // retorna mês/ano (dia sempre 1)
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final title =
        DateFormat.yMMMM(locale).format(_current); // "janeiro de 2026"

    final canGoPrev =
        !_isBeforeMin(DateTime(_current.year, _current.month - 1, 1));
    final canGoNext =
        !_isAfterMax(DateTime(_current.year, _current.month + 1, 1));

    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: Row(
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
            icon: Icon(
              widget.leftIcon,
              color: Colors.white,
            ),
            onPressed: canGoPrev ? () => _changeMonth(-1) : null,
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: widget.textStyle ??
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
            icon: Icon(
              widget.rightIcon,
              color: Colors.white,
            ),
            onPressed: canGoNext ? () => _changeMonth(1) : null,
          ),
        ],
      ),
    );
  }
}
