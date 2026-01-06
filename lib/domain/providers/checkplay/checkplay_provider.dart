import 'dart:io';

import 'package:checkplay_mobile/core/auth/models/user.dart';
import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';

mixin CheckplayProvider {
  Future<void> search(CheckplayFilter filter);
  Future<void> save();
  Future<void> initCheck(String id);
  Future<void> resetCheck(String id);
  Future<void> finishCheck(String id);
  Future<void> remove(String id);
  Future<void> upload(File file);
  void updateUser(User? user);
}
