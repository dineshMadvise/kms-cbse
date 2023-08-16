import 'dart:convert';

import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_h_w_remark_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/submit_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/homework_viewmodel.dart';

class HomeWorkLogic {
  /// SUBMIT HOMEWORK FROM PARENT LOGIN
  static Future<bool> submitHomeWork(SubmitHomeworkReqModel reqModel) async {
    HomeWorkViewModel _viewModel =
        Get.find(tag: HomeWorkViewModel().toString());
    await _viewModel.submitHomeworkList(reqModel);
    if (_viewModel.submitHomeworkApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.submitHomeworkApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        _viewModel.getHomeworkList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.submitHMFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  /// SAVE REMARK FROM TEACHER AND ADMIN LOGIN

  static Future<bool> saveHomeWorkRemark(SaveHWRemarkReqModel reqModel) async {
    HomeWorkViewModel _viewModel =
        Get.find(tag: HomeWorkViewModel().toString());
    await _viewModel.saveHomeworkReview(reqModel);
    if (_viewModel.saveHomeworkReviewApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.saveHomeworkReviewApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getHomeworkList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.saveHMReviewFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  /// ADD HOMEWORK

  static Future<bool> addHomework(AddHomeworkReqModel reqModel) async {
    HomeWorkViewModel _viewModel =
        Get.find(tag: HomeWorkViewModel().toString());
    await _viewModel.addHomeworkList(reqModel);
    if (_viewModel.addHomeworkApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.addHomeworkApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getHomeworkList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.addHMFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  /// UPDATE HOMEWORK

  static Future<bool> updateHomework(UpdateHomeworkReqModel reqModel) async {
    HomeWorkViewModel _viewModel =
        Get.find(tag: HomeWorkViewModel().toString());
    print('UPDATE HOMEQORK MODEL :=>${jsonEncode(reqModel.toJson())}');
    await _viewModel.updateHomework(reqModel);
    if (_viewModel.updateHomeworkApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.updateHomeworkApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        _viewModel.getHomeworkList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.addHMFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }


  ///
}
