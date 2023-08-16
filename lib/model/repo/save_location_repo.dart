import 'dart:convert';
import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/location_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';

class SaveLocationRepo extends BaseService {
  Future<dynamic> saveLocation() async {
    try {
      UserData data = ConstUtils.getUserData();
      final location = PreferenceManagerUtils.getLocationList();
      List<LocationReqModel> locationList =
          location.map((e) => LocationReqModel.fromJson(e)).toList();

      Map<String, dynamic> body = {
        "action": "location",
        "user_id": data.userid,
        "locations": locationList
      };
      print('REQ ODY:${jsonEncode(body)}');
      if (locationList.isEmpty) {
        return null;
      }
      var response =
          await ApiService().getResponse(apiType: APIType.aPost, body: body);
      // if (response == null) {
      //   return null;
      // }

      log("saveLocation  REPO : => $response");
      return response;
    } catch (e) {
      print('SAVE LOCATIOn ERROR :$e');
      return null;
    }
  }
}
