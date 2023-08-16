// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

import '../apiModel/responseModel/common_res_model.dart';

class UploadFileRepo extends BaseService {
  Future<CommonResModel> uploadFile(String path) async {
    Map<String, dynamic> body = {'attachment': path};

    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: body, fileUpload: true);
    print('RES....... :=>$response');
    final result = CommonResModel.fromJson(response);
    log("UploadFileRepo RESPONSE REPO : => $response");
    return result;
  }
}
