import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_lesson_plan_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_lesson_plan_status_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';

class LessonPlanLogic {
  static Future<bool> updateLessonPlanStatus(
      UpdateLessonPlanStatusReqModel reqModel) async {
    final _viewModel =
        Get.find<LessonPlanViewModel>(tag: LessonPlanViewModel().toString());
    await _viewModel.updateLessonPlanStatus(reqModel);
    if (_viewModel.updateLessonPlanListApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.updateLessonPlanListApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        showToast(
            msg: VariableUtils.lessonPlanUpdatedSuccessMsg, success: true);
        _viewModel.getLessonPlanList();
        await Future.delayed(Duration(seconds: 4));
        return true;
      } else {
        showToast(msg: VariableUtils.updateLessonPlanFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  static Future<bool> addLessonPlanStatus(
      AddLessonPlanReqModel reqModel) async {
    final _viewModel =
    Get.find<LessonPlanViewModel>(tag: LessonPlanViewModel().toString());
    await _viewModel.addLessonPlanStatus(reqModel);
    if (_viewModel.addLessonPlanListApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.addLessonPlanListApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        showToast(
            msg: VariableUtils.lessonPlanUpdatedSuccessMsg, success: true);
        _viewModel.getLessonPlanList();
        return true;
      } else {
        showToast(msg: VariableUtils.updateLessonPlanFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }


  static Future<bool> deleteLessonPlan(
      AddLessonPlanReqModel reqModel) async {
    final _viewModel =
    Get.find<LessonPlanViewModel>(tag: LessonPlanViewModel().toString());
    await _viewModel.deleteLessonPlan(reqModel.lessonPlanId!);
    if (_viewModel.deleteLessonPlanApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.deleteLessonPlanApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        showToast(
            msg: VariableUtils.lessonPlanUpdatedSuccessMsg, success: true);
        _viewModel.getLessonPlanList();
        return true;
      } else {
        showToast(msg: VariableUtils.updateLessonPlanFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

}
