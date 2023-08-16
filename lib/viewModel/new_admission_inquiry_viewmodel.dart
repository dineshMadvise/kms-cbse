// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/new_admission_inquiry_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/new_admission_inquiry_repo.dart';

class NewAdmissionInquiryViewModel extends GetxController {
  ApiResponse newAdmissionInquiryApiResponse = ApiResponse.initial('INITIAL');

  /// NewAdmissionInquiryApiResponse
  Future<void> addNewAdmissionInquiry(
      NewAdmissionInquiryReqModel reqModel) async {
    newAdmissionInquiryApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await AddNewAdmissionInquiryRepo()
          .addNewAdmissionInquiryRepo(reqModel);
      newAdmissionInquiryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('newAdmissionInquiryApiResponse ERROR :=> $e');
      newAdmissionInquiryApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
