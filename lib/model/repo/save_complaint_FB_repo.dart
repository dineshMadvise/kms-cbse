import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class SaveComplaintFBRepo extends BaseService {
  Future<CommonResModel> saveComplaintFB(
      {required String complaintId,
      required String feedback,
      bool isFeedback = false}) async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "saveComplaintFB",
      "user_type": data.usertype,
      "complaint_id": complaintId,
      "feedback": feedback,
      'type': isFeedback ? "feedback" : "complaint",
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = CommonResModel.fromJson(response);
    log("SAVE COMPLAIN FB RESPONSE REPO : => $response");
    return result;
  }
}
