import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/checkplay.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';

abstract interface class CheckplayService {
  Future<Either<ServiceException, List<Checkplay>>> search(
      CheckplayFilter filter);
  Future<Either<ServiceException, Nil>> update(Checkplay request);
  Future<Either<ServiceException, Nil>> create(Checkplay request);
  Future<Either<ServiceException, Nil>> upload(UploadDto dto);
  Future<Either<ServiceException, Nil>> resetCheck(String id);
  Future<Either<ServiceException, Nil>> initCheck(String id);
  Future<Either<ServiceException, Nil>> finishCheck(String id);
  Future<Either<ServiceException, Nil>> remove(String id);
  Future<Either<ServiceException, Checkplay>> findById(String id);
}
