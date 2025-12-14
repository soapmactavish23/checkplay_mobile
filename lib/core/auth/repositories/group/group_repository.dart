import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/auth/models/group.dart';

mixin GroupRepository {
  Future<Either<RepositoryException, Group>> create(Group obj);
  Future<Either<RepositoryException, Group>> update(Group obj);
  Future<Either<RepositoryException, Nil>> deleteById(String id);
  Future<Either<RepositoryException, Group>> findById(String id);
  Future<Either<RepositoryException, List<Group>>> findAll();
}
