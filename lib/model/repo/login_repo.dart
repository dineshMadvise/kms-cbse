import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/login_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class LoginRepo extends BaseService {
  Future<LoginResModel> login(LoginReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = LoginResModel.fromJson(response);
    log("LOGIN RESPONSE REPO : => $response");
    return result;
  }
}
