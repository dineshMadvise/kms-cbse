import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_new_sms_campaign_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/sms_viewmodel.dart';

class SmsLogic {
  static Future<bool> addSms(AddNewSmsCampaignReqModel reqModel) async {
    SmsViewModel _viewModel = Get.find(tag: SmsViewModel().toString());
    if (reqModel.publishTo == VariableUtils.all ||
        reqModel.publishTo == VariableUtils.teacher) {
      reqModel.classId = "";
      reqModel.sectionId = "";
      reqModel.studentId = "";
    } else if (reqModel.publishTo == VariableUtils.classStr) {
      reqModel.sectionId = "";
      reqModel.studentId = "";
      final classIds =
          ConstUtils.convertListToString(_viewModel.selectedClassList);
      if (classIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniClass);
        return false;
      }
      reqModel.classId = classIds;
    } else if (reqModel.publishTo == VariableUtils.classAndSection) {
      reqModel.studentId = "";
      final classIds =
          ConstUtils.convertListToString(_viewModel.selectedClassList);
      final sectionIds =
          ConstUtils.convertListToString(_viewModel.selectedSectionList);
      if (classIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniClass);
        return false;
      }
      if (sectionIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniSection);
        return false;
      }
      reqModel.classId = classIds;
      reqModel.sectionId = sectionIds;
    } else {
      reqModel.sectionId = "";
      final classIds =
          ConstUtils.convertListToString(_viewModel.selectedClassList);
      final studIds =
          ConstUtils.convertListToString(_viewModel.selectedClassStudList);
      if (classIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniClass);
        return false;
      }
      if (studIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniStud);
        return false;
      }
      reqModel.classId = classIds;
      reqModel.studentId = studIds;
    }

    await _viewModel.addSmsList(reqModel);
    if (_viewModel.addSmsListApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.addSmsListApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        _viewModel.getSmsList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.addSMSFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
