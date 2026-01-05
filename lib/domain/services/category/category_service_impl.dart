import 'dart:io';

import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/category.dart';
import 'package:checkplay_mobile/domain/repositories/category/category_repository_impl.dart';
import 'package:checkplay_mobile/domain/services/category/category_service.dart';

class CategoryServiceImpl implements CategoryService {
  final _repository = CategoryRepositoryImpl();

  @override
  Future<Either<ServiceException, Nil>> create(Category request) async {
    final result = await _repository.create(request);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, List<Category>>> findAll() async {
    final result = await _repository.findAll();
    switch (result) {
      case Success(value: List<Category> list):
        return Success(list);
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
  Future<Either<ServiceException, Nil>> update(Category request) async {
    final result = await _repository.update(request);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> uploadImage(
      String id, File image) async {
    final result = await _repository.uploadImage(id, image);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
