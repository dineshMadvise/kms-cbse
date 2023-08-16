
import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/requestModel/add_voice_call_campagin_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_cal_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/voice_temp_info_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class CallListRepo extends BaseService  {
  Future<GetCalListResModel> getCallList() async {
    UserData data = ConstUtils.getUserData();
    Map<String, dynamic> body = {
      "action" : "getcallCampaignList",
      "user_type":data.usertype,
    };
    var response = await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetCalListResModel.fromJson(response);
    log("GetCalListResModel : => $response");
    return result;
  }

  Future<CommonResModel> addCallList(AddVoiceCallCampaginReqModel  reqModel) async {
    UserData data = ConstUtils.getUserData();

    var response = await ApiService().getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    // if (response == null) {
    //   return null;
    // }
    final result = CommonResModel.fromJson(response);
    log("AddCalListResModel : => $response");
    return result;
  }


  Future<VoiceTempInfoResModel> getVoiceTempInfo(String tempId) async {
    Map<String, dynamic> body = {
      "action": "getcalltemplateInfo",
      "template_id": tempId
    };
    var response = await ApiService().getResponse(apiType: APIType.aPost, body: body);

    final result = VoiceTempInfoResModel.fromJson(response);
    log("VoiceTempInfoResModel : => $response");
    return result;
  }
}