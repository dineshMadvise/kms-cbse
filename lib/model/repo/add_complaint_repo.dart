import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/requestModel/add_complaint_req_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

import '../apiModel/responseModel/common_res_model.dart';

class AddComplaintRepo extends BaseService {
  Future<CommonResModel> addComplaint(AddComplaintReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    print('RES....... :=>$response');
    final result = CommonResModel.fromJson(response);
    log("ADD COMPLAINT RESPONSE REPO : => $response");
    return result;
  }
}
