import 'dart:io';

import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/checkplay.dart';

abstract interface class CheckplayService {
  Future<Either<ServiceException, List<Checkplay>>> search({
    String query = "",
    String categoryId = "",
    String status = "",
    int page = 0,
    int size = 10,
    String sort = '',
  });
  Future<Either<ServiceException, Nil>> update(Checkplay request);
  Future<Either<ServiceException, Nil>> create(Checkplay request);
  Future<Either<ServiceException, Nil>> upload(String id, File image);
  Future<Either<ServiceException, Nil>> resetCheck(String id);
  Future<Either<ServiceException, Nil>> initCheck(String id);
  Future<Either<ServiceException, Nil>> finishCheck(String id);
  Future<Either<ServiceException, Nil>> remove(String id);
}
