import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/new_admission_inquiry_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class AddNewAdmissionInquiryRepo extends BaseService {
  Future<CommonResModel> addNewAdmissionInquiryRepo(NewAdmissionInquiryReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("AddNewAdmissionInquiryRepo : => $response");
    return result;
  }
}
