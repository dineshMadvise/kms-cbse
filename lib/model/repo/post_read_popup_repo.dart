import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class PostReadPopUpRepo extends BaseService {
  Future<CommonResModel> postReadPopUpRepo(String popUpId) async {
    Map<String, dynamic> body = {"action": "readPopup", "popup_id": popUpId};

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = CommonResModel.fromJson(response);
    log("PostReadPopUpRepo  REPO : => $response");
    return result;
  }
}
