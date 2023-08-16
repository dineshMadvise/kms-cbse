// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_gps_status_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_daily_report_repo.dart';
import 'package:msp_educare_demo/model/repo/get_gps_status_repo.dart';
import 'package:msp_educare_demo/model/repo/save_location_repo.dart';
import 'package:msp_educare_demo/model/repo/update_user_status_repo.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class DashBoardViewModel extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  bool _isBackgroundServiceRunning = false;

  bool get isBackgroundServiceRunning => _isBackgroundServiceRunning;

  set isBackgroundServiceRunning(bool value) {
    _isBackgroundServiceRunning = value;
    update();
  }

  bool _backServiceInit = false;

  bool get backServiceInit => _backServiceInit;

  set backServiceInit(bool value) {
    _backServiceInit = value;
    update();
  }

  int _selectedBottomNaviIndex = 0;
  int _dashBoardHomeRoute = DashBoardHomeRoute.HomeTab.index;

  int get dashBoardHomeRoute => _dashBoardHomeRoute;

  set dashBoardHomeRoute(int value) {
    _dashBoardHomeRoute = value;
    update();
  }

  int get selectedBottomNaviIndex => _selectedBottomNaviIndex;

  set selectedBottomNaviIndex(int value) {
    _selectedBottomNaviIndex = value;
    update();
  }

  /// API CALL START ........................................

  ApiResponse studListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getGpsStatusApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse saveLocationApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateUserStatusApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse dailyReportApiResponse = ApiResponse.initial('INITIAL');

  /// GET GPS STATUS
  Future<void> getGpsStatus() async {
    getGpsStatusApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      GetGpsStatusResModel? response = await GetGpsStatusRepo().getGpsStatus();
      getGpsStatusApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getGpsStatusApiResponse ERROR :=> $e');
      getGpsStatusApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE LOCATION IN SERVER
  Future<void> saveLocation() async {
    saveLocationApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      Map<String, dynamic> response = await SaveLocationRepo().saveLocation();
      saveLocationApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveLocationApiResponse ERROR :=> $e');
      saveLocationApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// UPDATE USER STATUS
  Future<void> updateUserStatus({required String status}) async {
    updateUserStatusApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      Map<String, dynamic> response =
          await UpdateUserStatusRepo().updateUserStatus(status: status);
      updateUserStatusApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('updateUserStatusApiResponse ERROR :=> $e');
      updateUserStatusApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// DAILY REPORT
  Future<void> getDailyReport(DateTime dateTime) async {
    dailyReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetDailyReportRepo().getDailyReport(dateTime);
      dailyReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('dailyReportApiResponse ERROR :=> $e');
      dailyReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

}
