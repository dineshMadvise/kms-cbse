import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_claim_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetClaimOptionRepo extends BaseService {
  Future<GetClaimOptionResModel> getClaimOption() async {
    Map<String, dynamic> body = {
      "action": "getExpenseTypeOption",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetClaimOptionResModel.fromJson(response);
    log("GetClaimOptionResModel  REPO : => $response");
    return result;
  }
}
