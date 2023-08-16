// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/dashboard_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_dashboard_repo.dart';

class HomeViewModel extends GetxController {
  /// API CALL START ........................................

  ApiResponse dashboardApiResponse = ApiResponse.initial('INITIAL');

  /// GET DASHBOARD DATA
  Future<void> getDashboardData({String? userId}) async {
    // if (dashboardApiResponse.status == Status.INITIAL) {
    dashboardApiResponse = ApiResponse.loading('LOADING');
    // update();
    // }

    try {
      DashboardResModel? response =
          await GetDashBoardDataRepo().getDashboard(userId: userId);
      dashboardApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('dashboardApiResponse ERROR :=> $e');
      dashboardApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
