import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_lesson_plan_status_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class UpdateLessonPlanStatusRepo extends BaseService {
  Future<CommonResModel> updateLessonPlanStatusRepo(
      UpdateLessonPlanStatusReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("UpdateLessonPlanStatusRepo REPO : => $response");
    return result;
  }
}
