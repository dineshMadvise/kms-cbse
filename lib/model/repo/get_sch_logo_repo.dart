// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_school_logo_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetSchLogoRepo extends BaseService {
  Future<GetSchoolLogoResModel> getSchLogo() async {
    Map<String, dynamic> body = {"action": "getSchoolLogo"};
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    print('RESPO:=>$response');
    final result = GetSchoolLogoResModel.fromJson(response);
    log("GetSchoolLogoResModel  REPO : => $response");
    return result;
  }
}
