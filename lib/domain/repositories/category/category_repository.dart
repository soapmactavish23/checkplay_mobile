import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';

mixin CategoryRepository {
  Future<Either<RepositoryException, List<Category>>> findAll();
  Future<Either<RepositoryException, Nil>> update(Category request);
  Future<Either<RepositoryException, Nil>> create(Category request);
  Future<Either<RepositoryException, Nil>> remove(String id);
  Future<Either<RepositoryException, Nil>> uploadImage(UploadDto dto);
}
