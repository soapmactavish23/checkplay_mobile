// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

abstract class CheckplayStatus {
  static const PENDING = "PENDING";
  static const PROGRESS = "PROGRESS";
  static const FINISH = "FINISH";
  static const ALL = "";

  static const PENDENTE = "Pendente";
  static const EM_ANDAMENTO = "Em andamento";
  static const FINALIZADO = "Finalizado";
  static const TODOS = "Todos";

  static Color getColorByStatus(String status) {
    switch (status) {
      case CheckplayStatus.FINISH:
        return ColorsConstants.success;
      case CheckplayStatus.PROGRESS:
        return ColorsConstants.info;
      case CheckplayStatus.PENDING:
        return ColorsConstants.danger;
      default:
        return ColorsConstants.primary;
    }
  }

  static String getTitleByStatus(String status) {
    switch (status) {
      case CheckplayStatus.FINISH:
        return FINALIZADO;
      case CheckplayStatus.PROGRESS:
        return EM_ANDAMENTO;
      case CheckplayStatus.PENDING:
        return PENDENTE;
      default:
        return TODOS;
    }
  }
}
