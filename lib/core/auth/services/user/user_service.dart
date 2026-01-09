import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/auth/models/dto/password_dto.dart';
import 'package:checkplay_mobile/core/auth/models/dto/profile_dto.dart';
import 'package:checkplay_mobile/core/auth/models/token.dart';
import 'package:checkplay_mobile/core/auth/models/user.dart';

mixin UserService {
  Future<Either<ServiceException, List<User>>> search(
      {String name = '', String email = ''});
  Future<Either<ServiceException, Nil>> resetPassword(String id);
  Future<Either<ServiceException, Nil>> changePassword(PasswordDto passwordDTO);
  Future<Either<ServiceException, Nil>> editProfile(ProfileDto profileDTO);
  Future<Either<ServiceException, User>> create(User obj);
  Future<Either<ServiceException, User>> update(User obj);
  Future<Either<ServiceException, Nil>> deleteById(String id);
  Future<Either<ServiceException, User>> findByCode(String code);
  Future<Either<ServiceException, Token>> signIn(String email, String password);
  Future<Either<ServiceException, Nil>> register(User obj);
  Future<Either<ServiceException, Nil>> changeStatus(String id);
}
