import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/apply_payment_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_apply_payment_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_stud_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payment_mode_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_student_pending_fee_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

/// ============================= GET BANK ACCOUNT OPTION ============================= ///
class GetBankAccountRepo extends BaseService {
  Future<GetMultipleClassStudOptionResModel> getBankAccount() async {
    Map<String, dynamic> body = {
      "action": "getBankAccount",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = GetMultipleClassStudOptionResModel.fromJson(response);
    log("getBankAccount  REPO : => $response");
    return result;
  }
}

/// ============================= GET PAYMENT MODE OPTION ============================= ///
class GetPaymentModeRepo extends BaseService {
  Future<GetPaymentModeResModel> getPaymentMode() async {
    Map<String, dynamic> body = {
      "action": "getPaymentMode",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = GetPaymentModeResModel.fromJson(response);
    log("getPaymentMode  REPO : => $response");
    return result;
  }
}

/// ============================= GET STUDENT PENDING FEES OPTION ============================= ///
class GetStudentPendingFeeRepo extends BaseService {
  Future<GetStudentPendingFeeResModel> getStudentPendingFee(
      String studId) async {
    Map<String, dynamic> body = {
      "action": "getStudentPendingFee",
      "user_type": ConstUtils.getUserData().usertype,
      "student_id": studId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = GetStudentPendingFeeResModel.fromJson(response);
    log("GetStudentPendingFeeRepo  REPO : => $response");
    return result;
  }
}

/// ============================= APPLY PAYMENT  ============================= ///
class ApplyPaymentRepo extends BaseService {
  Future<CommonResModel> applyPayment(ApplyPaymentReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("ApplyPaymentRepo  REPO : => $response");
    return result;
  }
}

/// ============================= GET APPLY PAYMENT LIST  ============================= ///
class GetApplyPaymentListRepo extends BaseService {
  Future<GetApplyPaymentListResModel> getApplyPayment(DateTime dateTime) async {
    final Map<String, dynamic> body = {
      "action": "getApplyPaymentList",
      "user_type": ConstUtils.getUserData().usertype,
      "date": DateFormatUtils.ddMMYYYY2Format(dateTime)
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = GetApplyPaymentListResModel.fromJson(response);
    log("GetApplyPaymentListResModel  REPO : => $response");
    return result;
  }
}
