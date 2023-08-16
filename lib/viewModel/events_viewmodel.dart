// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_event_list_repo.dart';

class EventsViewModel extends GetxController {
  ApiResponse getEventListApiResponse = ApiResponse.initial('INITIAL');

  /// GET EVENT LIST
  Future<void> getEventList() async {
    getEventListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetEventListRepo().getEventList();
      getEventListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getEventListApiResponse ERROR :=> $e');
      getEventListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
