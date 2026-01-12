import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/domain/models/dto/check_qtd_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/dashboard_request.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_category_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_dto.dart';
import 'package:checkplay_mobile/domain/providers/dashboard/dashboard_provider.dart';
import 'package:checkplay_mobile/domain/services/dashboard/dashboard_service_impl.dart';
import 'package:flutter/material.dart';

class DashboardProviderImpl extends ChangeNotifier with DashboardProvider {
  final _service = DashboardServiceImpl();

  DashboardRequest request = DashboardRequest.empty();
  List<QtdCategoryDto> listCategories = [];
  List<CheckQtdDto> listChecks = [];
  QtdDto qtdDto = QtdDto.empty();

  bool _loading = false;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  @override
  Future<void> loadCategoryByMonthAndYear() async {
    loading = true;
    final result = await _service.loadCategoryByMonthAndYear(request);
    loading = false;
    switch (result) {
      case Success(:final value):
        listCategories = value;
        return;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> loadChecksByMonthAndYear() async {
    loading = true;
    final result = await _service.loadChecksByMonthAndYear(request);
    loading = false;
    switch (result) {
      case Success(:final value):
        listChecks = value;
        return;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> loadQtdByMonthAndYear() async {
    loading = true;
    final result = await _service.loadQtdByMonthAndYear(request);
    loading = false;
    switch (result) {
      case Success(:final value):
        qtdDto = value;
        return;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }
}
