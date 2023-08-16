import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../model/apis/api_response.dart';
import '../viewModel/notification_viewmodel.dart';

class NotificationLogic {
  static Future<void> updateNotificationCount(String nId) async {
    NotificationViewModel _viewModel =
        Get.find(tag: NotificationViewModel().toString());
    await _viewModel.updateNotificationCount(nId);
    if (_viewModel.updateNotificationCountApiResponse.status ==
        Status.COMPLETE) {
      CommonResModel response =
          _viewModel.updateNotificationCountApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getNotificationList();
        // showToast(msg: response.data!, success: true);
      } else {
        showToast(msg: VariableUtils.updateNotiCountFailedMsg);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }
}
