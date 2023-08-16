import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/responseModel/get_app_version.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetAppVersionRepo extends BaseService {
  Future<GetAppVersionResModel> getAppVersion() async {
    Map<String, dynamic> body = {
      "action": "getVersion",
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = GetAppVersionResModel.fromJson(response);
    log("GetAppVersionResModel  REPO : => $response");
    return result;
  }
}
