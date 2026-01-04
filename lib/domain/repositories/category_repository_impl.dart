import 'dart:developer';

import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/rest_client/rest_client.dart';
import 'package:checkplay_mobile/domain/models/category.dart';
import 'package:checkplay_mobile/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends RestClient with CategoryRepository {
  @override
  Future<Either<RepositoryException, Nil>> create(Category request) async {
    try {
      await auth.post('/categorias', data: request.toMap());
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Error creating category";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, List<Category>>> findAll() async {
    try {
      final response = await auth.get('/categorias');
      final list = List<Map<String, dynamic>>.from(response.data).toList();
      return Success(list.map<Category>((e) => Category.fromMap(e)).toList());
    } catch (e, s) {
      const msg = "Error finding categories";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> update(Category request) async {
    try {
      await auth.put('/categorias', data: request.toMap());
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Error updating category";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> remove(String id) async {
    try {
      await auth.delete('/categorias/$id');
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Error removing category";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }
}
