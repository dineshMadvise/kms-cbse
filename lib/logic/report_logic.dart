import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_expenses_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../viewModel/report_viewmodel.dart';

class ReportLogic{
  static Future<bool> saveExpenses(EditExpensesReqModel reqModel) async {
    ReportViewModel _viewModel =
    Get.find(tag: ReportViewModel().toString());
    await _viewModel.saveExpenses(reqModel);
    if (_viewModel.editExpensesReportApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.editExpensesReportApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        showToast(msg: VariableUtils.submitExpSuccessMsg, success: true);
         _viewModel.getExpensesReport();

        return true;
      } else {
        showToast(msg: VariableUtils.submitExpFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.submitExpFailedMsg);
      return false;
    }
  }
}