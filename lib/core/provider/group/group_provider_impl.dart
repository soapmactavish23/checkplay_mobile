import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/auth/models/group.dart';
import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/provider/group/group_provider.dart';
import 'package:checkplay_mobile/core/auth/services/group/group_service_impl.dart';

class GroupProviderImpl extends ChangeNotifier with GroupProvider {
  bool _loading = false;
  Group obj = Group.empty();
  List<Group> list = [];
  List<Group> listFiltered = [];
  final service = GroupServiceImpl();

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  @override
  Future<void> save() async {
    loading = true;
    Either<ServiceException, Group>? result;
    if (obj.id == null) {
      result = await service.create(obj);
    } else {
      result = await service.update(obj);
    }
    loading = false;

    switch (result) {
      case Success():
        await findAll();
        Future.value();
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> delete() async {
    loading = true;
    final result = await service.deleteById(obj.id!);
    obj = Group.empty();
    loading = false;
    switch (result) {
      case Success():
        await findAll();
        Future.value();
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> findAll() async {
    loading = true;
    final result = await service.findAll();
    loading = false;
    switch (result) {
      case Success(:final value):
        list = value;
        listFiltered = list;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  void search(String value) {
    loading = true;
    listFiltered = list
        .where(
            (group) => group.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    loading = false;
  }

  void updateUser(User? user) {
    if (user != null) {
      if (user.group.id == GroupsConstants.ADMIN_ID) {
        findAll();
      }
    }
  }
}
