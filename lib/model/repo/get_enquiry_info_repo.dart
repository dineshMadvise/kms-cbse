import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_enquiry_info_res_modeldart.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetEnquiryInfoRepo extends BaseService {
  Future<GetEnquiryInfoResModel> getEnquiryInfoRepo(String id) async {
    Map<String, dynamic> body = {"action": "getEnquiryInfo", "id": id};
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetEnquiryInfoResModel.fromJson(response);
    log("GetEnquiryInfoResModel  REPO : => $response");
    return result;
  }
}
