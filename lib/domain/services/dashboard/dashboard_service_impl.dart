import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/domain/models/dto/check_qtd_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/dashboard_request.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_category_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_dto.dart';
import 'package:checkplay_mobile/domain/repositories/dashboard/dashboard_repository_impl.dart';
import 'package:checkplay_mobile/domain/services/dashboard/dashboard_service.dart';

class DashboardServiceImpl implements DashboardService {
  final _repository = DashboardRepositoryImpl();

  @override
  Future<Either<ServiceException, List<QtdCategoryDto>>>
      loadCategoryByMonthAndYear(DashboardRequest request) async {
    final result = await _repository.loadCategoryByMonthAndYear(request);
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, List<CheckQtdDto>>> loadChecksByMonthAndYear(
      DashboardRequest request) async {
    final result = await _repository.loadChecksByMonthAndYear(request);
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, QtdDto>> loadQtdByMonthAndYear(
      DashboardRequest request) async {
    final result = await _repository.loadQtdByMonthAndYear(request);
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
