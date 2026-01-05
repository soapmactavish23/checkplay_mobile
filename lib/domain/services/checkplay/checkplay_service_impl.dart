import 'dart:io';

import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/checkplay.dart';
import 'package:checkplay_mobile/domain/repositories/checkplay/checkplay_repository_impl.dart';
import 'package:checkplay_mobile/domain/services/checkplay/checkplay_service.dart';

class CheckplayServiceImpl implements CheckplayService {
  final _repository = CheckplayRepositoryImpl();

  @override
  Future<Either<ServiceException, Nil>> create(Checkplay request) async {
    final result = await _repository.create(request);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> finishCheck(String id) async {
    final result = await _repository.finishCheck(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> initCheck(String id) async {
    final result = await _repository.initCheck(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> remove(String id) async {
    final result = await _repository.remove(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> resetCheck(String id) async {
    final result = await _repository.resetCheck(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, List<Checkplay>>> search(
      {String query = "",
      String categoryId = "",
      String status = "",
      int page = 0,
      int size = 10,
      String sort = ''}) async {
    final result = await _repository.search(
        query: query,
        categoryId: categoryId,
        status: status,
        page: page,
        size: size,
        sort: sort);

    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> update(Checkplay request) async {
    final result = await _repository.update(request);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> upload(String id, File image) async {
    final result = await _repository.upload(id, image);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
