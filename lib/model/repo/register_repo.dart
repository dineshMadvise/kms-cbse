import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/register_req_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class RegisterRepo extends BaseService {
  Future<dynamic> register(RegisterReqModel reqModel) async {
    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        body: reqModel.toJson());
    log("GET IN SCHOOL RESPONSE REPO : => $response");
    return response;
  }
}
