// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_claim_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/add_claim_repo.dart';
import 'package:msp_educare_demo/model/repo/get_claim_list_repo.dart';

class ClaimViewModel extends GetxController {
  String _selectedFile = '';

  String get selectedFile => _selectedFile;

  set selectedFile(String value) {
    _selectedFile = value;
    update();
  }

  void clearSelectedFile() {
    _selectedFile = "";
    addClaimListApiResponse = ApiResponse.initial('INITIAL');
  }

  ApiResponse getClaimListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse addClaimListApiResponse = ApiResponse.initial('INITIAL');

  /// GET CLAIM LIST
  Future<void> getComplaintList() async {
    getClaimListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetClaimListRepo().getClaimList();
      getClaimListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getClaimListApiResponse ERROR :=> $e');
      getClaimListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ADD CLAIM LIST
  Future<void> addClaimList(AddClaimReqModel reqModel) async {
    addClaimListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await AddClaimRepo().addClaim(reqModel);
      addClaimListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('addClaimListApiResponse ERROR :=> $e');
      addClaimListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
