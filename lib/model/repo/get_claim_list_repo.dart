import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/responseModel/get_claim_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetClaimListRepo extends BaseService {
  Future<GetClaimListResModel> getClaimList() async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "getClaimReqList",
      "user_type": data.usertype,
      "user_id": data.userid
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetClaimListResModel.fromJson(response);
    log("GetClaimListResModel  REPO : => $response");
    return result;
  }
}
