// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_noti_count_repo.dart';
import 'package:msp_educare_demo/model/repo/get_noti_list_repo.dart';
import 'package:msp_educare_demo/model/repo/update_noti_count_repo.dart';

class NotificationViewModel extends GetxController {
  ApiResponse getNotificationListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getNotificationCountApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateNotificationCountApiResponse =
      ApiResponse.initial('INITIAL');

  /// GET NOTIFICATION LIST
  Future<void> getNotificationList() async {
    if (getNotificationListApiResponse.status != Status.COMPLETE) {
      getNotificationListApiResponse = ApiResponse.loading('LOADING');
    }
    // update();
    try {
      final response = await GetNotificationListRepo().getNotificationList();
      getNotificationListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getNotificationListApiResponse ERROR :=> $e');
      getNotificationListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET NOTIFICATION COUNT
  Future<void> getNotificationCount() async {
    if (getNotificationCountApiResponse.status != Status.COMPLETE) {
      getNotificationCountApiResponse = ApiResponse.loading('LOADING');
      update();
    }

    try {
      final response = await GetNotificationCountRepo().getNotificationCount();
      getNotificationCountApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getNotificationCountApiResponse ERROR :=> $e');
      getNotificationCountApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// UPDATE NOTIFICATION COUNT
  Future<void> updateNotificationCount(String nId) async {
    updateNotificationCountApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await UpdateNotificationCountRepo().updateNotificationCount(nId);
      getNotificationCount();
      updateNotificationCountApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('updateNotificationCountApiResponse ERROR :=> $e');
      updateNotificationCountApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
