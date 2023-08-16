import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_score_by_subject_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_score_by_subject_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetExamScoreBySubjectRepo extends BaseService {
  Future<GetExamScoreBySubjectResModel> getExamScoreBySubjectRepo(
      GetExamScoreBySubjectReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
    );

    final result = GetExamScoreBySubjectResModel.fromJson(response);
    log("GetExamScoreBySubjectResModel  REPO : => $response");
    return result;
  }
}
