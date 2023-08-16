import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_new_sms_campaign_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_sms_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_temp_info_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_template_id_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class SmsListRepo extends BaseService {
  Future<GetSmsListResModel> getSmsList() async {
    UserData data = ConstUtils.getUserData();
    Map<String, dynamic> body = {
      "action" : "getsmsCampaignList",
      "user_type":data.usertype,
    };
    var response = await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetSmsListResModel.fromJson(response);
    log("Get SMSList REPO : => $response");
    return result;
  }
  Future<CommonResModel> addSmsList(AddNewSmsCampaignReqModel  reqModel) async {


    var response = await ApiService().getResponse(apiType: APIType.aPost, body: reqModel.toJson());

    final result = CommonResModel.fromJson(response);
    log("ADD SMSList REPO : => $response");
    return result;
  }

  Future<GetTempIdResModel> tempInfo(String tempId) async {

    Map<String, dynamic> body = {
      "action" : "getsmstemplateinfo",
      "template_id" : tempId
    };


    var response = await ApiService().getResponse(apiType: APIType.aPost, body:body);

    final result = GetTempIdResModel.fromJson(response);
    log("TempInfo  REPO : => $response");
    return result;
  }



}
