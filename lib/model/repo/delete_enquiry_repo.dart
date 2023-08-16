import 'dart:developer';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import '../apiModel/responseModel/common_res_model.dart';

class DeleteEnquiryRepo extends BaseService {
  Future<CommonResModel> deleteEnquiry(String id) async {
    Map<String, dynamic> body = {"action": "deleteEnquiry", "id": id};
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    print('RES....... :=>$response');
    final result = CommonResModel.fromJson(response);
    log("DELETE ENQUIRY RESPONSE REPO : => $response");
    return result;
  }
}
