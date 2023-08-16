import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/logic/fees_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/apply_fees_payment_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/assets/icons_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void razorPayService(
    {required double tax,
    required double amount,
    // required String contact,
    required String razorKey,
    // required String addressId,
    required String feesId}) {
  Razorpay razorpay = Razorpay();
  UserData userData = ConstUtils.getUserData();
  var options = {
    'key': razorKey,
    // 'key': "rzp_test_Ov3UQjnTKwefJb",
    'amount': (tax + amount) * 100,
    'name': 'Fees',
    'description': '',
    'retry': {'enabled': true, 'max_count': 1},
    'prefill': {
      'contact': userData.mobileNumber ?? "",
      "email": userData.email == "" || userData.email == null
          ? 'guest@gmail.com'
          : userData.email
    },
    'external': {
      'wallets': ['paytm']
    }
  };

  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (res) {
    handlePaymentSuccessResponse(res, amount, tax, feesId);
  });
  razorpay.open(options);
}

Future<void> handlePaymentErrorResponse(PaymentFailureResponse response) async {
  logs('TRANSITION ERROR ---------> ${response.error} ---------------------');
  logs('TRANSITION MESSAGE -------> ${response.message} -------------------');
  logs('TRANSITION CODE ------------> ${response.code} --------------------');

  logs('TRANSITION ID -------> ${response.error!["metadata"]["payment_id"]}');

  return showAlertDialog(VariableUtils.paymentFailedText);
}

Future<void> handlePaymentSuccessResponse(PaymentSuccessResponse response,
    double amount, double tax, String feesId) async {
  logs('TRANSITION ID ------------> ${response.paymentId} ---------------');
  logs('TRANSITION ORDER ID ------> ${response.orderId} -----------------');
  logs('TRANSITION SIGNATURE -----> ${response.signature} ---------------');
  logs('TRANSITION AMOUNT -----> $amount ---------------');
  logs('FEES ID -----> $feesId ---------------');

  ApplyFeesPaymentReqModel reqModel = ApplyFeesPaymentReqModel();
  reqModel.transactionId = response.paymentId;
  reqModel.paidAmount = amount.toString();
  reqModel.txAmount = tax.toString();
  reqModel.feesId = feesId;
  final status = await FeesLogic.applyFeesAmount(reqModel);
  if (status) {
    Get.back();
  }
}

void showAlertDialog(String title) {
  Get.dialog(AlertDialog(
    title: Column(
      children: [
        title == VariableUtils.paymentSuccessText
            ? IconsWidgets.successPayment
            : IconsWidgets.cancelPayment,
        SizeConfig.sH3,
        Text(title),
      ],
    ),
  ));
}
