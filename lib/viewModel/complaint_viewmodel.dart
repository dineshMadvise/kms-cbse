// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_complaint_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/add_complaint_repo.dart';
import 'package:msp_educare_demo/model/repo/get_compaint_list_repo.dart';
import 'package:msp_educare_demo/model/repo/save_complaint_FB_repo.dart';

class ComplaintViewModel extends GetxController {
  String _selectedFile = '';

  String get selectedFile => _selectedFile;

  set selectedFile(String value) {
    _selectedFile = value;
    update();
  }

  ApiResponse getComplaintListApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse addComplaintListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse saveComplaintFBApiResponse = ApiResponse.initial('INITIAL');

  /// GET COMPLAINT LIST
  Future<void> getComplaintList({bool isFeedback = false}) async {
    getComplaintListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetComplaintListRepo().getComplaintList(isFeedback: isFeedback);
      getComplaintListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getComplaintListApiResponse ERROR :=> $e');
      getComplaintListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ADD COMPLAINT LIST
  Future<void> addComplaintList(AddComplaintReqModel reqModel) async {
    addComplaintListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await AddComplaintRepo().addComplaint(reqModel);
      addComplaintListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('addComplaintListApiResponse ERROR :=> $e');
      addComplaintListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE COMPLAINT FB
  Future<void> saveComplaintFB(
      {required String complaintId,
      required String feedback,
      bool isFeedback = false}) async {
    saveComplaintFBApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SaveComplaintFBRepo().saveComplaintFB(
          complaintId: complaintId, feedback: feedback, isFeedback: isFeedback);
      saveComplaintFBApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveComplaintFBApiResponse ERROR :=> $e');
      saveComplaintFBApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
