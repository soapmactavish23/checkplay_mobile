import 'package:checkplay_mobile/domain/models/dto/dashboard_request.dart';

mixin DashboardProvider {
  Future<void> loadCategoryByMonthAndYear();
  Future<void> loadChecksByMonthAndYear();
  Future<void> loadQtdByMonthAndYear();
  Future<void> changeRequest(DashboardRequest req);
}
