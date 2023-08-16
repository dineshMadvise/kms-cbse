import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_enquiry_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class SaveEnquiryRepo extends BaseService {
  Future<CommonResModel> saveEnquiryRepo(SaveEnquiryReqModel reqModel,
      {required bool isUpdate}) async {
    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        body: isUpdate ? reqModel.updateToJson() : reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("SAVE ENQUIRE RESPONSE REPO : => $response");
    return result;
  }
}
