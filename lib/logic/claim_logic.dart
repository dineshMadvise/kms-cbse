import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_claim_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/claim_viewmodel.dart';

class ClaimLogic {
  static Future<bool> addClaim(AddClaimReqModel reqModel) async {
    ClaimViewModel _viewModel = Get.find(tag: ClaimViewModel().toString());
    await _viewModel.addClaimList(reqModel);
    if (_viewModel.addClaimListApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.addClaimListApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getComplaintList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.saveClaimFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
