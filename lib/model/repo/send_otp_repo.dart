import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/send_otp_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/send_otp_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class SendOtpRepo extends BaseService {
  Future<SendOtpResModel> sendOtp({required SendOtpReqModel model}) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: model.toJson());
    log("SendOtpResModel  REPO : => $response");
    // if (response == null) {
    //   return null;
    // }
    final result = SendOtpResModel.fromJson(response);

    return result;
  }
}
