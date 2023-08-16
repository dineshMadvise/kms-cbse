import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_h_w_remark_req_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

import '../apiModel/responseModel/common_res_model.dart';

class SaveHomeworkReviewRepo extends BaseService {
  Future<CommonResModel> saveHomeworkReview(
      SaveHWRemarkReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("SaveHomeworkReviewRepo RESPONSE REPO : => $response");
    return result;
  }
}
