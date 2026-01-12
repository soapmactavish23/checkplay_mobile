import 'dart:developer';

import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/rest_client/rest_client.dart';
import 'package:checkplay_mobile/domain/models/dto/check_qtd_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/dashboard_request.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_category_dto.dart';
import 'package:checkplay_mobile/domain/models/dto/qtd_dto.dart';
import 'package:checkplay_mobile/domain/repositories/dashboard/dashboard_repository.dart';

class DashboardRepositoryImpl extends RestClient with DashboardRepository {
  @override
  Future<Either<RepositoryException, List<QtdCategoryDto>>>
      loadCategoryByMonthAndYear(DashboardRequest request) async {
    try {
      final result = await auth.get('/dashboard/categories',
          queryParameters: request.toMap());
      final list = List<Map<String, dynamic>>.from(result.data).toList();
      return Success(
          list.map<QtdCategoryDto>((e) => QtdCategoryDto.fromMap(e)).toList());
    } on Exception catch (e, s) {
      const msg = "Erro ao listar categorias por mês e ano.";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, List<CheckQtdDto>>>
      loadChecksByMonthAndYear(DashboardRequest request) async {
    try {
      final result =
          await auth.get('/dashboard/checks', queryParameters: request.toMap());
      final list = List<Map<String, dynamic>>.from(result.data).toList();
      return Success(
          list.map<CheckQtdDto>((e) => CheckQtdDto.fromMap(e)).toList());
    } on Exception catch (e, s) {
      const msg = "Erro ao listar checks por mês e ano.";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, QtdDto>> loadQtdByMonthAndYear(
      DashboardRequest request) async {
    try {
      final result =
          await auth.get('/dashboard', queryParameters: request.toMap());
      return Success(QtdDto.fromMap(result.data));
    } on Exception catch (e, s) {
      const msg = "Erro ao listar valores por mês e ano.";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }
}
