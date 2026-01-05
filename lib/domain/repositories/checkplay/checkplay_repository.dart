import 'dart:io';

import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/checkplay.dart';

mixin CheckplayRepository {
  Future<Either<RepositoryException, List<Checkplay>>> search({
    String query = "",
    String categoryId = "",
    String status = "",
    int page = 0,
    int size = 10,
    String sort = '',
  });
  Future<Either<RepositoryException, Nil>> update(Checkplay request);
  Future<Either<RepositoryException, Nil>> create(Checkplay request);
  Future<Either<RepositoryException, Nil>> upload(String id, File image);
  Future<Either<RepositoryException, Nil>> resetCheck(String id);
  Future<Either<RepositoryException, Nil>> initCheck(String id);
  Future<Either<RepositoryException, Nil>> finishCheck(String id);
  Future<Either<RepositoryException, Nil>> remove(String id);
}
