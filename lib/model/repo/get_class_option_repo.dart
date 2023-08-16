import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetClassOptionRepo extends BaseService {
  Future<GetClassOptionResModel> getClassOption() async {
    Map<String, dynamic> body = {
      "action": "getClassOption",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetClassOptionResModel.fromJson(response);
    log("GetClassOptionResModel  REPO : => $response");
    return result;
  }

}
