import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_stud_att_list_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_stud_att_list_res_modeldart.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetStudAttListRepo extends BaseService {
  Future<GetStudAttListResModel> getStudAttList(
      GetStudAttListReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = GetStudAttListResModel.fromJson(response);
    log("ADD GetStudAttListResModel RESPONSE REPO : => $response");
    return result;
  }
}
