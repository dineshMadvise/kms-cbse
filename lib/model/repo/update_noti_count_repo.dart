import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

import '../apiModel/responseModel/common_res_model.dart';

class UpdateNotificationCountRepo extends BaseService {
  Future<CommonResModel> updateNotificationCount(String nId) async {
    UserData data = ConstUtils.getUserData();
    Map<String, dynamic> body = {
      "action": "updateNotificationcount",
      "user_type": data.usertype,
      "notification_id": nId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = CommonResModel.fromJson(response);
    log("UpdateNotificationCountRepo RESPONSE REPO : => $response");
    return result;
  }
}
