import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetExamOptionRepo extends BaseService {
  Future<GetExamOptionResModel> getExamOptionRepo(
      GetExamOptionReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson(), );

    final result = GetExamOptionResModel.fromJson(response);
    log("GetExamOptionResModel  REPO : => $response");
    return result;
  }
}
