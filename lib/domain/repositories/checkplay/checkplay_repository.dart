import 'package:checkplay_mobile/core/exception/repository_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/checkplay.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';

mixin CheckplayRepository {
  Future<Either<RepositoryException, List<Checkplay>>> search(
      CheckplayFilter filter);
  Future<Either<RepositoryException, Nil>> update(Checkplay request);
  Future<Either<RepositoryException, Nil>> create(Checkplay request);
  Future<Either<RepositoryException, Nil>> upload(UploadDto dto);
  Future<Either<RepositoryException, Nil>> resetCheck(String id);
  Future<Either<RepositoryException, Nil>> initCheck(String id);
  Future<Either<RepositoryException, Nil>> finishCheck(String id);
  Future<Either<RepositoryException, Nil>> remove(String id);
  Future<Either<RepositoryException, Checkplay>> findById(String id);
}
