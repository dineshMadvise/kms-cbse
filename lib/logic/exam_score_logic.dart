import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_exam_score_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/exam_score_viewmodel.dart';

class ExamScoreLogic {


  static Future<bool> updateExamScore(UpdateExamScoreReqModel reqModel) async {
    ExamScoreViewModel _viewModel =
    Get.find<ExamScoreViewModel>(tag: ExamScoreViewModel().toString());
    await _viewModel.updateExamScore(reqModel);
    if (_viewModel.updateExamScoreApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.updateExamScoreApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.addExamScoreFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
