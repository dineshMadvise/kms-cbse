import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/requestModel/add_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

import '../apiModel/responseModel/common_res_model.dart';

class AddHomeworkRepo extends BaseService {
  Future<CommonResModel> addHomework(AddHomeworkReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("ADD HOMEWORK RESPONSE REPO : => $response");
    return result;
  }
}

/// ===================== UPDATE HOMEWORK ===================
class UpdateHomeworkRepo extends BaseService {
  Future<CommonResModel> updateHomework(UpdateHomeworkReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("UPDATE HOMEWORK RESPONSE REPO : => $response");
    return result;
  }
}
