import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_leave_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_leave_approval_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../viewModel/leave_viewmodel.dart';

class LeaveLogic {
  /// SAVE LEAVE APPROVAL
  static Future<void> saveLeaveApproval(
      SaveLeaveApprovalReqModel reqModel) async {
    LeaveViewModel _viewModel = Get.find(tag: LeaveViewModel().toString());
    await _viewModel.saveLeaveApprove(reqModel);
    if (_viewModel.saveLeaveApprovalApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.saveLeaveApprovalApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getLeaveApprovalList();
        showToast(msg: response.data!, success: true);
      } else {
        showToast(msg: VariableUtils.saveLeaveApprovalFailedMsg);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }

  /// ADD LEAVE REQUEST
  static Future<bool> addLeaveRequest(AddLeaveReqModel reqModel) async {
    LeaveViewModel _viewModel = Get.find(tag: LeaveViewModel().toString());
    await _viewModel.addLeaveReqList(reqModel);
    if (_viewModel.addLeaveReqListApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.addLeaveReqListApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getLeaveReqList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.addLeaveRequestFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
