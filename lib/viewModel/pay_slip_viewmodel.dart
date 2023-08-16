// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_payslip_list_repo.dart';

class PaySlipViewModel extends GetxController {
  ApiResponse getPaySlipListApiResponse = ApiResponse.initial('INITIAL');

  /// GET PAY SLIP LIST
  Future<void> getPaySlipList() async {
    getPaySlipListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetPaySlipListRepo().getPaySlipList();
      getPaySlipListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getPaySlipListApiResponse ERROR :=> $e');
      getPaySlipListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
