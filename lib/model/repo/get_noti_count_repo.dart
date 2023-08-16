import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetNotificationCountRepo extends BaseService {
  Future<CommonResModel> getNotificationCount() async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "getNotificationCount",
      "user_type": data.usertype,
      "user_id": data.userid,
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = CommonResModel.fromJson(response);
    log("ADD getNotificationCount RESPONSE REPO : => $response");
    return result;
  }
}
