import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/core/auth/models/group.dart';
import 'package:checkplay_mobile/core/auth/repositories/group/group_repository_impl.dart';
import 'package:checkplay_mobile/core/auth/services/group/group_service.dart';

class GroupServiceImpl implements GroupService {
  final _repository = GroupRepositoryImpl();

  @override
  Future<Either<ServiceException, Group>> create(Group obj) async {
    final result = await _repository.create(obj);
    switch (result) {
      case Success(value: Group user):
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
  Future<Either<ServiceException, List<Group>>> findAll() async {
    final result = await _repository.findAll();
    switch (result) {
      case Success(value: List<Group> list):
        return Success(list);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Group>> findById(String id) async {
    final result = await _repository.findById(id);
    switch (result) {
      case Success(value: Group obj):
        return Success(obj);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, Group>> update(Group obj) async {
    final result = await _repository.update(obj);
    switch (result) {
      case Success(value: Group obj):
        return Success(obj);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
