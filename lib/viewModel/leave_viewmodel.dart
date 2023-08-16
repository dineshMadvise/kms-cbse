// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_leave_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_leave_approval_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/add_leave_req_repo.dart';
import 'package:msp_educare_demo/model/repo/get_leave_approval_list_repo.dart';
import 'package:msp_educare_demo/model/repo/get_leave_req_ist_repo.dart';
import 'package:msp_educare_demo/model/repo/save_leave_approve_repo.dart';

class LeaveViewModel extends GetxController {
  String _selectedFile = '';

  String get selectedFile => _selectedFile;

  set selectedFile(String value) {
    _selectedFile = value;
    update();
  }

  void resetAddLeaveReq() {
    addLeaveReqListApiResponse = ApiResponse.initial('INITIAL');
  }

  ApiResponse getLeaveReqListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse addLeaveReqListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getLeaveApprovalListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse saveLeaveApprovalApiResponse = ApiResponse.initial('INITIAL');

  /// GET LEAVE REQ LIST
  Future<void> getLeaveReqList() async {
    getLeaveReqListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetLeaveReqListRepo().getLeaveReqList();
      getLeaveReqListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getLeaveReqListApiResponse ERROR :=> $e');
      getLeaveReqListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ADD LEAVE REQ LIST
  Future<void> addLeaveReqList(AddLeaveReqModel reqModel) async {
    addLeaveReqListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await AddLeaveReqRepo().addLeaveReq(reqModel);
      addLeaveReqListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('addLeaveReqListApiResponse ERROR :=> $e');
      addLeaveReqListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE LEAVE APPROVE
  Future<void> saveLeaveApprove(SaveLeaveApprovalReqModel reqModel) async {
    saveLeaveApprovalApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SaveLeaveApproveRepo().saveLeaveApprove(reqModel);
      saveLeaveApprovalApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveLeaveApprovalApiResponse ERROR :=> $e');
      saveLeaveApprovalApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET LEAVE APPROVAL LIST

  Future<void> getLeaveApprovalList() async {
    getLeaveApprovalListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetLeaveApprovalListRepo().getLeaveApprovalList();
      getLeaveApprovalListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getLeaveApprovalListApiResponse ERROR :=> $e');
      getLeaveApprovalListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
