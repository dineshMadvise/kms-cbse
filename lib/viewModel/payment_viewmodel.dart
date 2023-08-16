// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/apply_payment_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/apply_payment_option_repo.dart';

class PaymentViewModel extends GetxController{
  DateTime _currentValue = DateTime.now();

  DateTime get currentValue => _currentValue;

  set currentValue(DateTime value) {
    _currentValue = value;
    update();
  }

  ApiResponse getPaymentListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse saveApplyPaymentApiResponse = ApiResponse.initial('INITIAL');

  /// GET PAYMENT LIST
  Future<void> getPaymentList() async {
    getPaymentListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetApplyPaymentListRepo().getApplyPayment(_currentValue);
      getPaymentListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getPaymentListApiResponse ERROR :=> $e');
      getPaymentListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE APPLY PAYMENT
  Future<void> saveApplyPayment(ApplyPaymentReqModel reqModel) async {
    saveApplyPaymentApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ApplyPaymentRepo().applyPayment(reqModel);
      saveApplyPaymentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveApplyPaymentApiResponse ERROR :=> $e');
      saveApplyPaymentApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

}