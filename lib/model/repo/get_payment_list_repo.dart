// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payment_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class GetPaymentListRepo extends BaseService {
  Future<GetPaymentListResModel> getPaymentList() async {
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();

    Map<String, dynamic> body = {
      "action": "getPaymentList",
      "user_type": data.usertype,
      "student_id":
          data.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
              ? studentData.id
              : "0"
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    print('RES:=>$response');
    final result = GetPaymentListResModel.fromJson(response);
    log("GetPaymentListResModel  REPO : => $response");
    return result;
  }
}
