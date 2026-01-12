import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/domain/models/dto/check_qtd_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/dashboard_request.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_category_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_dto.dart';

mixin DashboardService {
  Future<Either<ServiceException, List<QtdCategoryDto>>>
      loadCategoryByMonthAndYear(DashboardRequest request);
  Future<Either<ServiceException, List<CheckQtdDto>>> loadChecksByMonthAndYear(
      DashboardRequest request);
  Future<Either<ServiceException, QtdDto>> loadQtdByMonthAndYear(
      DashboardRequest request);
}
