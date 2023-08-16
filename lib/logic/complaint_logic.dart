import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_complaint_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/complaint_viewmodel.dart';

class ComplaintLogic {
  static Future<bool> addComplaint(AddComplaintReqModel reqModel,
      {bool isFeedback = false}) async {
    ComplaintViewModel _viewModel =
        Get.find(tag: ComplaintViewModel().toString());
    if (isFeedback) {
      reqModel.type = "feedback";
    } else {
      reqModel.type = "complaint";
    }
    await _viewModel.addComplaintList(reqModel);
    if (_viewModel.addComplaintListApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.addComplaintListApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getComplaintList(isFeedback: isFeedback);
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(
            msg: isFeedback
                ? VariableUtils.addFeedbackFailedMsg
                : VariableUtils.addComplaintFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  static Future<bool> saveComplaintFb(
      {required String complaintId,
      required String feedback,
      bool isFeedback = false}) async {
    ComplaintViewModel _viewModel =
        Get.find(tag: ComplaintViewModel().toString());
    await _viewModel.saveComplaintFB(
        complaintId: complaintId, feedback: feedback, isFeedback: isFeedback);
    if (_viewModel.saveComplaintFBApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.saveComplaintFBApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getComplaintList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.saveComplaintFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
