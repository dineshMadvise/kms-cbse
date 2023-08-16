import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/requestModel/add_leave_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class AddLeaveApprovalRepo extends BaseService {
  Future<CommonResModel> addLeaveApproval(AddLeaveReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("ADD LEAVE APPROVAL RESPONSE REPO : => $response");
    return result;
  }
}
