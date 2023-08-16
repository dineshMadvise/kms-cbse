import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_nationality_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetNationalityOptionRepo extends BaseService {
  Future<GetNationalityResModel> getNationalityOptionRepo() async {
    Map<String, dynamic> body = {
      "action": "getNationality",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetNationalityResModel.fromJson(response);
    log("GetNationalityResModel  REPO : => $response");
    return result;
  }
}
