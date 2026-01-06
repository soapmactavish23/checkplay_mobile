import 'dart:io';

import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/core/exception/service_exception.dart';
import 'package:checkplay_mobile/core/fp/either.dart';
import 'package:checkplay_mobile/core/fp/nil.dart';
import 'package:checkplay_mobile/domain/models/dto/upload_dto.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';
import 'package:checkplay_mobile/domain/providers/category/category_provider.dart';
import 'package:checkplay_mobile/domain/services/category/category_service_impl.dart';
import 'package:flutter/material.dart';

class CategoryProviderImpl extends ChangeNotifier implements CategoryProvider {
  Category obj = Category.empty();
  List<Category> list = [];
  List<Category> listFiltered = [];

  bool _loading = false;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final _service = CategoryServiceImpl();

  CategoryProviderImpl();

  void updateUser(User? user) {
    if (user != null) {
      findAll();
    }
  }

  @override
  Future<void> findAll() async {
    loading = true;
    final result = await _service.findAll();
    loading = false;
    switch (result) {
      case Success(:final value):
        list = value;
        listFiltered = list;
      case Failure(:final exception):
        return Future.error(exception);
    }
  }

  @override
  Future<void> remove(String id) async {
    loading = true;
    final result = await _service.remove(id);
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
        await findAll();
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  Future<void> uploadImage(File file) async {
    loading = true;
    final result =
        await _service.uploadImage(UploadDto(id: obj.id!, image: file));
    loading = false;

    switch (result) {
      case Success():
        await findAll();
      case Failure(:final exception):
        return Future.error(exception.message);
    }
  }

  @override
  void search(String value) {
    loading = true;
    listFiltered = list
        .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    loading = false;
  }
}
