import 'dart:io';

import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/checkplay.dart';
import 'package:checkplay_mobile/domain/providers/checkplay/checkplay_provider.dart';
import 'package:checkplay_mobile/domain/services/checkplay/checkplay_service_impl.dart';
import 'package:flutter/material.dart';

class CheckplayProviderImpl extends ChangeNotifier with CheckplayProvider {
  Checkplay obj = Checkplay.empty();
  List<Checkplay> list = [];
  CheckplayFilter filter = CheckplayFilter();

  bool _loading = false;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final _service = CheckplayServiceImpl();

  @override
  Future<void> finishCheck(String id) async {
    loading = true;
    final result = await _service.finishCheck(id);
    loading = false;
    switch (result) {
      case Success():
        return;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> initCheck(String id) async {
    loading = true;
    final result = await _service.initCheck(id);
    loading = false;
    switch (result) {
      case Success():
        return;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> remove(String id) async {
    loading = true;
    final result = await _service.remove(id);
    loading = false;
    switch (result) {
      case Success():
        return;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> resetCheck(String id) async {
    loading = true;
    final result = await _service.resetCheck(id);
    loading = false;
    switch (result) {
      case Success():
        return;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> save() async {
    loading = true;
    Either<ServiceException, Nil> result;
    if (obj.id == null) {
      result = await _service.create(obj);
    } else {
      result = await _service.update(obj);
    }

    switch (result) {
      case Success():
        await search();
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> search() async {
    loading = true;
    final result = await _service.search(filter);
    loading = false;
    switch (result) {
      case Success(:final value):
        list = value;
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  void updateUser(User? user) {
    if (user != null) {
      search();
    }
  }

  @override
  Future<void> upload(File file) async {
    loading = true;
    final result = await _service.upload(UploadDto(id: obj.id!, image: file));
    loading = false;
    switch (result) {
      case Success():
        await search();
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }
}
