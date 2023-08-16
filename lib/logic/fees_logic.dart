import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/apply_fees_payment_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_lesson_plan_status_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/fees_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';

class FeesLogic {
  static Future<bool> applyFeesAmount(
      ApplyFeesPaymentReqModel reqModel) async {
    final _viewModel =
    Get.find<FeesViewModel>(tag: FeesViewModel().toString());
    await _viewModel.applyFeesAmount(reqModel);
    if (_viewModel.applyFeesPaymentApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.applyFeesPaymentApiResponse.data;
      print('FEES APPLY RESPONSE :$response');
      if (response.status == VariableUtils.ok) {
        showToast(
            msg: VariableUtils.feesApplySuccessMsg, success: true);
        _viewModel.getPaymentList();
        await Future.delayed(Duration(seconds: 4));
        return true;
      } else {
        showToast(msg: VariableUtils.feesApplyFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
