// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_enquiry_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/delete_enquiry_repo.dart';
import 'package:msp_educare_demo/model/repo/get_enquiry_info_repo.dart';
import 'package:msp_educare_demo/model/repo/get_enquiry_list_repo.dart';
import 'package:msp_educare_demo/model/repo/save_enquiry_repo.dart';

class EnquiryViewModel extends GetxController {
  ApiResponse saveEnquiryApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getEnquiryListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getEnquiryInfoApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse deleteEnquiryApiResponse = ApiResponse.initial('INITIAL');

  /// SAVE ENQUIRY LIST
  Future<void> saveEnquiryList(SaveEnquiryReqModel reqModel,
      {required bool isUpdate}) async {
    saveEnquiryApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await SaveEnquiryRepo().saveEnquiryRepo(reqModel, isUpdate: isUpdate);
      saveEnquiryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveEnquiryApiResponse ERROR :=> $e');
      saveEnquiryApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET ENQUIRY LIST
  Future<void> getEnquiryList() async {
    if (getEnquiryListApiResponse.status != Status.COMPLETE) {
      getEnquiryListApiResponse = ApiResponse.loading('LOADING');
      update();
    }
    try {
      final response = await GetEnquiryListRepo().getEnquiryListRepo();
      getEnquiryListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getEnquiryListApiResponse ERROR :=> $e');
      getEnquiryListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET ENQUIRY INFO
  Future<void> getEnquiryInfo(String id) async {
    getEnquiryInfoApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetEnquiryInfoRepo().getEnquiryInfoRepo(id);
      getEnquiryInfoApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getEnquiryInfoApiResponse ERROR :=> $e');
      getEnquiryInfoApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// DELETE ENQUIRY
  Future<void> deleteEnquiry(String id) async {
    deleteEnquiryApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await DeleteEnquiryRepo().deleteEnquiry(id);
      deleteEnquiryApiResponse = ApiResponse.complete(response);
      getEnquiryList();
    } catch (e) {
      print('deleteEnquiryApiResponse ERROR :=> $e');
      deleteEnquiryApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
