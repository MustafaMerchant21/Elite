import 'package:elite/core/error/failure.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/domain/model/overview_model.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/domain/model/recent_activity_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, OverviewModel>> dashboardOverview({
    required String title,
    required String value
  });
  Future<Either<Failure, RecentActivityModel>> dashboardRecentActivity({
    required String activity,
    required String date,
    required String time
  });
}
