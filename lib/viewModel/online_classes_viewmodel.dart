// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';

import '../model/repo/get_online_class_list_repo.dart';

class OnlineClassesViewModel extends GetxController {
  ApiResponse getOnlineCLassListApiResponse = ApiResponse.initial('INITIAL');

  /// GET ONLINE CLASS LIST
  Future<void> getOnlineClassList() async {
    getOnlineCLassListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetOnlineClassListRepo().getOnlineClassList();
      getOnlineCLassListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getOnlineCLassListApiResponse ERROR :=> $e');
      getOnlineCLassListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
