import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/requestModel/reset_pass_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/send_otp_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class ResetPassRepo extends BaseService {
  Future<SendOtpResModel> resetPass(
      {required ResetPasswordReqModel model}) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: model.toJson());
    // if (response == null) {
    //   return null;
    // }
    final result = SendOtpResModel.fromJson(response);
    log("ResetPassRepo  REPO : => $response");
    return result;
  }
}
