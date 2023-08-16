import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_enquiry_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/enquiry_viewmodel.dart';

class EnquiryLogic {
  /// SAVE AND UPDATE ENQUIRY
  static Future<bool> saveEnquiry(SaveEnquiryReqModel reqModel,
      {required bool isUpdate}) async {
    EnquiryViewModel _viewModel = Get.find(tag: EnquiryViewModel().toString());
    await _viewModel.saveEnquiryList(reqModel, isUpdate: isUpdate);
    if (_viewModel.saveEnquiryApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.saveEnquiryApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        showToast(msg: response.data!, success: true);
        _viewModel.getEnquiryList();
        return true;
      } else {
        showToast(msg: VariableUtils.saveEnquiryFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  /// DELETE ENQUIRY
  static Future<bool> deleteEnquiry(SaveEnquiryReqModel reqModel) async {
    EnquiryViewModel _viewModel = Get.find(tag: EnquiryViewModel().toString());
    await _viewModel.deleteEnquiry(reqModel.id!);
    if (_viewModel.deleteEnquiryApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.deleteEnquiryApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        showToast(msg: response.data!, success: true);
        _viewModel.getEnquiryList();
        return true;
      } else {
        showToast(msg: VariableUtils.deleteEnquiryFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
