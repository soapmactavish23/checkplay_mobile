import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/auth/models/dto/password_dto.dart';
import 'package:checkplay_mobile/core/auth/models/dto/profile_dto.dart';
import 'package:checkplay_mobile/core/auth/repositories/user/user_repository_impl.dart';
import 'package:checkplay_mobile/core/auth/models/token.dart';
import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/core/auth/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final _repository = UserRepositoryImpl();

  @override
  Future<Either<ServiceException, Nil>> changePassword(
      PasswordDto passwordDTO) async {
    final result = await _repository.changePassword(passwordDTO);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, User>> create(User obj) async {
    final result = await _repository.create(obj);
    switch (result) {
      case Success(value: User user):
        return Success(user);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> deleteById(String id) async {
    final result = await _repository.deleteById(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> editProfile(
      ProfileDto profileDTO) async {
    final result = await _repository.editProfile(profileDTO);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, User>> findByCode(String code) async {
    final result = await _repository.findByCode(code);
    switch (result) {
      case Success(value: User user):
        return Success(user);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> resetPassword(String id) async {
    final result = await _repository.resetPassword(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, List<User>>> search(
      {String name = '', String email = ''}) async {
    final result = await _repository.search(name: name, email: email);
    switch (result) {
      case Success(value: List<User> list):
        return Success(list);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, User>> update(User obj) async {
    final result = await _repository.update(obj);
    switch (result) {
      case Success(value: User user):
        return Success(user);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Token>> signIn(
      String email, String password) async {
    final result = await _repository.signIn(email, password);
    switch (result) {
      case Success(value: final Token token):
        return Success(token);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> register(User obj) async {
    final result = await _repository.register(obj);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> changeStatus(String id) async {
    final result = await _repository.changeStatus(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Token>> refreshToken(
      String refreshToken) async {
    final result = await _repository.refreshToken(refreshToken);
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
