// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';

import '../model/repo/get_transport_info_repo.dart';

class TransportInfoViewModel extends GetxController {
  ApiResponse getTransportInfoApiResponse = ApiResponse.initial('INITIAL');

  /// GET TRANSPORT INFO LIST
  Future<void> getTransportInfo() async {
    if (getTransportInfoApiResponse.status != Status.COMPLETE) {
      getTransportInfoApiResponse = ApiResponse.loading('LOADING');
      update();
    }

    try {
      final response = await GetTransportInfoRepo().getTransportInfo();
      getTransportInfoApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getTransportInfoApiResponse ERROR :=> $e');
      getTransportInfoApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
