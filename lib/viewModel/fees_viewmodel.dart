// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/apply_fees_payment_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/apply_fees_payment_repo.dart';
import 'package:msp_educare_demo/model/repo/get_fees_payment_list_repo.dart';
import 'package:msp_educare_demo/model/repo/get_payment_list_repo.dart';

class FeesViewModel extends GetxController {
  ApiResponse getFeesPaymentListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse applyFeesPaymentApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getPaymentListApiResponse = ApiResponse.initial('INITIAL');

  /// GET FEES LIST
  Future<void> getFeesPaymentList() async {
    getFeesPaymentListApiResponse = ApiResponse.loading('LOADING');
    // update();
    try {
      final response = await GetFeesPaymentListRepo().getFeesPaymentList();
      getFeesPaymentListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getFeesPaymentListApiResponse ERROR :=> $e');
      getFeesPaymentListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET PAYMENT LIST
  Future<void> getPaymentList() async {
    getPaymentListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetPaymentListRepo().getPaymentList();
      getPaymentListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getPaymentListApiResponse ERROR :=> $e');
      getPaymentListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// APPLY FEES AMOUNT
  Future<void> applyFeesAmount(ApplyFeesPaymentReqModel reqModel) async {
    applyFeesPaymentApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ApplyFeesAmountRepo().applyFeesAmount(reqModel);
      applyFeesPaymentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('applyFeesPaymentApiResponse ERROR :=> $e');
      applyFeesPaymentApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
