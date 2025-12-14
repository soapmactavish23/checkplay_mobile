import 'dart:developer';

import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/auth/models/group.dart';
import 'package:checkplay_mobile/core/auth/repositories/group/group_repository.dart';
import 'package:checkplay_mobile/core/rest_client/rest_client.dart';

class GroupRepositoryImpl extends RestClient implements GroupRepository {
  @override
  Future<Either<RepositoryException, Group>> create(Group obj) async {
    try {
      final response = await auth.post(
        '/grupos',
        data: obj.toMap(),
      );
      return Success(Group.fromMap(response.data));
    } on Exception catch (e, s) {
      String msg = 'Erro ao criar grupo';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> deleteById(String id) async {
    try {
      await auth.delete('/grupos/$id');
      return Success(nil);
    } on Exception catch (e, s) {
      String msg = 'Erro ao deletar grupo';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, List<Group>>> findAll() async {
    try {
      final response = await auth.get('/grupos');
      final list = List<Map<String, dynamic>>.from(response.data).toList();
      return Success(list.map<Group>((e) => Group.fromMap(e)).toList());
    } catch (e, s) {
      String msg = 'Erro ao listar grupos';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Group>> findById(String id) async {
    try {
      final response = await auth.get('/grupos/$id');
      return Success(Group.fromMap(response.data));
    } catch (e, s) {
      String msg = 'Erro ao pesquisar grupo por id';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Group>> update(Group obj) async {
    try {
      final response = await auth.put(
        '/grupos',
        data: obj.toMap(),
      );
      return Success(Group.fromMap(response.data));
    } catch (e, s) {
      String msg = 'Erro ao atualizar o grupo';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }
}
