import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/checkplay.dart';
import 'package:checkplay_mobile/domain/repositories/checkplay/checkplay_repository_impl.dart';
import 'package:checkplay_mobile/domain/services/checkplay/checkplay_service.dart';

class CheckplayServiceImpl implements CheckplayService {
  final _repository = CheckplayRepositoryImpl();

  @override
  Future<Either<ServiceException, Checkplay>> create(Checkplay request) async {
    final result = await _repository.create(request);
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> finishCheck(String id) async {
    final result = await _repository.finishCheck(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> initCheck(String id) async {
    final result = await _repository.initCheck(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> remove(String id) async {
    final result = await _repository.remove(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> resetCheck(String id) async {
    final result = await _repository.resetCheck(id);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, List<Checkplay>>> search(filter) async {
    final result = await _repository.search(filter);

    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Checkplay>> update(Checkplay request) async {
    final result = await _repository.update(request);
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> upload(UploadDto dto) async {
    final result = await _repository.upload(dto);
    switch (result) {
      case Success():
        return Success(nil);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Checkplay>> findById(String id) async {
    final result = await _repository.findById(id);
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
