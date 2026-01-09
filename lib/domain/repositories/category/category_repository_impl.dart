import 'dart:developer';
import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/rest_client/config/http_methods.dart';
import 'package:checkplay_mobile/core/rest_client/rest_client.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/domain/repositories/category/category_repository.dart';
import 'package:dio/dio.dart';

class CategoryRepositoryImpl extends RestClient with CategoryRepository {
  @override
  Future<Either<RepositoryException, Category>> create(Category request) async {
    try {
      final result = await auth.post('/categorias', data: request.toMap());
      return Success(Category.fromMap(result.data));
    } on Exception catch (e, s) {
      const msg = "Erro ao criar categoria";
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
      const msg = "Erro ao listar categorias";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Category>> update(Category request) async {
    try {
      final result = await auth.put('/categorias', data: request.toMap());
      return Success(Category.fromMap(result.data));
    } on Exception catch (e, s) {
      const msg = "Erro ao atualizar categoria";
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
      const msg = "Erro ao remover categoria";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> uploadImage(UploadDto dto) async {
    try {
      await auth.request(
        '/categorias/upload',
        data: await dto.toMap(),
        options: Options(
          method: HttpMethods.put,
          headers: {
            Headers.contentTypeHeader: "multipart/form-data",
          },
          receiveTimeout: const Duration(seconds: 120),
        ),
      );
      return Success(nil);
    } catch (e, s) {
      String msg = 'Erro ao enviar imagem da categoria';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Category>> findById(String id) async {
    try {
      final result = await auth.get('/categorias/$id');
      return Success(Category.fromMap(result.data));
    } on Exception catch (e, s) {
      String msg = 'Erro ao pesquisar a categoria';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }
}
