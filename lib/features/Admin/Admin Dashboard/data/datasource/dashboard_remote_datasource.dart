import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class DashboardRemoteDatasource {
  Future<Map<String,dynamic>> dashboardOverview();

  Future<String> dashboardRecentActivity(
      {required String acivity, required String date, required String time});
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final FirebaseFirestore db;
  late SharedPreferences prefs;

  DashboardRemoteDatasourceImpl(this.db);
  @override
  Future<Map<String,dynamic>> dashboardOverview() async {
    try{
      final overview = await db.collection('dashboard').doc('overview').get();
      prefs = await SharedPreferences.getInstance();
      prefs.setString("total_sales", overview['total_sales'].toString());
      prefs.setString("products_sold", overview['products_sold'].toString());
      prefs.setString("users", overview['users'].toString());
      prefs.setString("reviews", overview['reviews'].toString());
      prefs.setString("orders", overview['orders'].toString());
      prefs.setString("sign_ups", overview['sign_ups'].toString());
      return overview;
    }catch(e){
      print("=== Error: $e ===");
    }
  }

  @override
  Future<String> dashboardRecentActivity({required String acivity, required String date, required String time}) {
    // TODO: implement dashboardRecentActivity
    throw UnimplementedError();
  }
  
}
