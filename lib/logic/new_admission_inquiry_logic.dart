import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/new_admission_inquiry_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/new_admission_inquiry_viewmodel.dart';

class NewAdmissionInquiryLogic {

  static Future<bool> addNewAdmissionInquiry(
      NewAdmissionInquiryReqModel reqModel) async {
   final _viewModel = Get.find<NewAdmissionInquiryViewModel>(
        tag: NewAdmissionInquiryViewModel().toString());
    await _viewModel.addNewAdmissionInquiry(reqModel);
    if (_viewModel.newAdmissionInquiryApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.newAdmissionInquiryApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        showToast(
            msg: VariableUtils.saveNewAdmissionInquirySuccessMsg,
            success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.saveNewAdmissionInquiryFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
