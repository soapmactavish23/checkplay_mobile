import 'package:checkplay_mobile/domain/models/dto/checkplay_filter.dart';

mixin CheckplayProvider {
  Future<void> search(CheckplayFilter filter);
  Future<void> save();
  Future<void> initCheck(int id);
  Future<void> resetCheck(int id);
  Future<void> finishCheck(int id);
  Future<void> remove(int id);
}
