import 'dart:developer';

import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/auth/models/dto/password_dto.dart';
import 'package:checkplay_mobile/core/auth/models/dto/profile_dto.dart';
import 'package:checkplay_mobile/core/auth/repositories/user/user_repository.dart';
import 'package:checkplay_mobile/core/auth/models/token.dart';
import 'package:checkplay_mobile/core/rest_client/rest_client.dart';
import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends RestClient with UserRepository {
  @override
  Future<Either<RepositoryException, Nil>> changePassword(
      PasswordDto passwordDTO) async {
    try {
      await auth.put(
        '/usuarios/alterar-senha',
        data: passwordDTO.toMap(),
      );
      return Success(nil);
    } on Exception catch (e, s) {
      String msg = 'Erro ao deletar o usuário';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, User>> create(User obj) async {
    try {
      final response = await auth.post('/usuarios', data: obj.toMap());
      return Success(User.fromMap(response.data));
    } on Exception catch (e, s) {
      String msg = 'Erro ao criar usuário';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> deleteById(String id) async {
    try {
      await auth.delete('/usuarios/$id');
      return Success(Nil());
    } catch (e, s) {
      String msg = 'Erro ao deletar usuário';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> editProfile(
      ProfileDto profileDTO) async {
    try {
      await auth.put(
        '/usuarios/editar-perfil',
        data: profileDTO.toMap(),
      );
      return Success(Nil());
    } catch (e, s) {
      String msg = 'Erro ao editar perfil';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, User>> findByCode(String code) async {
    try {
      final response = await auth.get('/usuarios/$code');
      return Success(User.fromMap(response.data));
    } catch (e, s) {
      String msg = 'Erro ao pesquisar o código';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> resetPassword(String id) async {
    try {
      await auth.put(
        '/usuarios/resetar-senha/$id',
      );
      return Success(nil);
    } catch (e, s) {
      String msg = 'Erro ao resetar senha';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, List<User>>> search({
    String name = '',
    String email = '',
  }) async {
    try {
      final response = await auth.get('/usuarios', queryParameters: {
        'name': name,
        'email': email,
        'page': 0,
        'size': 10,
      });
      final list =
          List<Map<String, dynamic>>.from(response.data['content']).toList();
      return Success(list.map<User>((e) => User.fromMap(e)).toList());
    } catch (e, s) {
      String msg = 'Erro ao pesquisar usuários';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, User>> update(User obj) async {
    try {
      final response = await auth.put('/usuarios', data: obj.toMap());
      return Success(User.fromMap(response.data));
    } catch (e, s) {
      String msg = 'Erro ao atualizar usuário';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Token>> signIn(
      String email, String password) async {
    try {
      final response = await unAuth.post('/usuarios/login', data: {
        'email': email,
        'password': password,
      });
      return Success(Token.fromMap(response.data));
    } on DioException catch (e, s) {
      String msg = 'Usuário ou senha incorretos. Acesso negado.';
      log(msg, error: e.message, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    } on Exception catch (e, s) {
      String msg = 'Usuário ou senha incorretos. Acesso negado.';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> register(User obj) async {
    try {
      await unAuth.post('/usuarios/registrar', data: {
        'name': obj.name,
        'email': obj.email,
        'password': obj.password
      });

      return Success(nil);
    } catch (e, s) {
      String msg = 'Erro ao registrar usuário';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> changeStatus(String id) async {
    try {
      await auth.put('/usuarios/status/$id');
      return Success(nil);
    } catch (e, s) {
      String msg = 'Erro ao atualizar usuário';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Token>> refreshToken(
      String refreshToken) async {
    try {
      final response = await unAuth
          .post('/usuarios/refresh', data: {'refreshToken': refreshToken});
      return Success(Token.fromMap(response.data));
    } on Exception catch (e, s) {
      String msg = 'Usuário ou senha incorretos. Acesso negado.';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }
}
