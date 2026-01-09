import 'dart:io';

import 'package:checkplay_mobile/core/auth/models/user.dart';

mixin CheckplayProvider {
  Future<void> search();
  Future<void> save();
  Future<void> initCheck(String id);
  Future<void> resetCheck(String id);
  Future<void> finishCheck(String id);
  Future<void> remove(String id);
  Future<void> upload(File file);
  Future<void> changeAction();
  void updateUser(User? user);
  Future<void> findById();
}
