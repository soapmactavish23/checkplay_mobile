import 'dart:developer';

import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/rest_client/rest_client.dart';
import 'package:checkplay_mobile/domain/models/checkplay.dart';
import 'package:checkplay_mobile/domain/repositories/checkplay/checkplay_repository.dart';

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
      {String query = "",
      String categoryId = "",
      String status = "",
      int page = 0,
      int size = 10,
      String sort = ''}) {
    // TODO: implement search
    throw UnimplementedError();
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
  Future<Either<RepositoryException, Nil>> upload(Checkplay request) {
    // TODO: implement upload
    throw UnimplementedError();
  }
}
