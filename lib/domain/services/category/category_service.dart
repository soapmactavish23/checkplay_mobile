import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';

abstract interface class CategoryService {
  Future<Either<ServiceException, List<Category>>> findAll();
  Future<Either<ServiceException, Nil>> update(Category request);
  Future<Either<ServiceException, Nil>> create(Category request);
  Future<Either<ServiceException, Nil>> remove(String id);
  Future<Either<ServiceException, Nil>> uploadImage(UploadDto dto);
}
