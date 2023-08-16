import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_enquiry_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetEnquiryListRepo extends BaseService {
  Future<GetEnquiryListResModel> getEnquiryListRepo() async {
    UserData userData = ConstUtils.getUserData();
    Map<String, dynamic> body = {
      "action": "getEnquiryList",
      "user_id": userData.userid,
      "user_type": userData.usertype
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetEnquiryListResModel.fromJson(response);
    log("GetEnquiryListResModel  REPO : => $response");
    return result;
  }
}
