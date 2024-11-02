import 'package:elite/core/error/failure.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/domain/model/recent_activity_model.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/src/either.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource dashboardRemoteDatasource;

  DashboardRepositoryImpl(this.dashboardRemoteDatasource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> dashboardOverview() async{
    final Map<String,dynamic> data = await dashboardRemoteDatasource.dashboardOverview();
    return data;
  }

  @override
  Future<Either<Failure, RecentActivityModel>> dashboardRecentActivity({required String activity, required String date, required String time}) {
    // TODO: implement dashboardRecentActivity
    throw UnimplementedError();
  }


}