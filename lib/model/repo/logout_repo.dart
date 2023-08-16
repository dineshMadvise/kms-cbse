import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class LogOutRepo extends BaseService {
  Future<dynamic> logout() async {
    UserData data = ConstUtils.getUserData();
    Map<String, dynamic> body = {
      "action": "logout",
      "user_type": data.usertype,
      "user_id": data.userid
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    log("LOGOUT RESPONSE REPO : => $response");

    return response;
  }
}
