import 'dart:developer';
import 'dart:io';

import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/rest_client/config/http_methods.dart';
import 'package:checkplay_mobile/core/rest_client/rest_client.dart';
import 'package:checkplay_mobile/domain/models/entities/checkplay.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';
import 'package:checkplay_mobile/domain/repositories/checkplay/checkplay_repository.dart';
import 'package:dio/dio.dart';

class CheckplayRepositoryImpl extends RestClient with CheckplayRepository {
  @override
  Future<Either<RepositoryException, Nil>> create(Checkplay request) async {
    try {
      await auth.post('/check-play', data: request.toMap());
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Erro ao criar checkplay";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> finishCheck(String id) async {
    try {
      await auth.put('/check-play/finalizar-check/$id');
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Erro ao finalizar checkplay";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> initCheck(String id) async {
    try {
      await auth.put('/check-play/iniciar-check/$id');
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Erro ao iniciar checkplay";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> remove(String id) async {
    try {
      await auth.delete('/check-play/$id');
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Erro ao remover checkplay";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> resetCheck(String id) async {
    try {
      await auth.put('/check-play/$id');
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Erro ao reinciar checkplay";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, List<Checkplay>>> search(
      CheckplayFilter filter) async {
    try {
      final response = await auth.get('/check-play', queryParameters: {
        'query': filter.query,
        'categoryId': filter.categoryId,
        'status': filter.status,
        'page': filter.page,
        'size': filter.size,
        'sort': filter.sort
      });

      final content = response.data['content'];
      final list = List<Map<String, dynamic>>.from(content).toList();
      return Success(list.map<Checkplay>((e) => Checkplay.fromMap(e)).toList());
    } on Exception catch (e, s) {
      String msg = 'Erro ao listar checkplays';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> update(Checkplay request) async {
    try {
      await auth.put('/check-play', data: request.toMap());
      return Success(nil);
    } on Exception catch (e, s) {
      const msg = "Erro ao reinciar checkplay";
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> upload(String id, File image) async {
    try {
      FormData formData = FormData.fromMap({
        "id": id,
        "file": await MultipartFile.fromFile(
          image.path,
        ),
      });

      await auth.request(
        '/check-play/upload',
        data: formData,
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
      String msg = 'Erro ao enviar imagem do checkplay';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }
}
