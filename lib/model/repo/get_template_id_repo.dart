import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/responseModel/get_template_id_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetTemplateIdRepo extends BaseService {
  Future<GetTemplateIdResModel> getSectionOption(bool isVoice) async {
    Map<String, dynamic> body = {
    "action": isVoice ?"getcalltemplateOption" :"getsmstemplateOption"

    };
    var response =
    await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    // final result = GetTemplateIdResModel.fromJson(response);
    final result = GetTemplateIdResModel.fromJson(response);
    log("GetTemplateIdResModel  REPO : => $response");

    return result;
  }
}