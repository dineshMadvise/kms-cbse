import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/logic/fees_logic.dart';
import 'package:msp_educare_demo/logic/lesson_plan_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/apply_fees_payment_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_lesson_plan_status_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_lesson_plan_list.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payment_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/services/razor_pay_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/fees_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';

void showFeesPayDialog(FeesData data, String txCharge,
    GetPaymentListResModel paymentListResModel) {
  String remark = data.feeType!;
  num remainAmount = (data.demandAmount ?? 0) - (data.paidAmt ?? 0);
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: DecorationUtils.dialogDecorationBox(),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        VariableUtils.payFees,
                        style: FontTextStyle.poppinsW6S13Grey,
                      ),
                      DialogCloseBtn(),
                    ],
                  ),
                ),
                SizeConfig.sH10,
                Divider(),
                SizeConfig.sH5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    titleText: VariableUtils.remainingAmount,
                    regularExpression: RegularExpression.pricePattern,
                    textInputType:
                        TextInputType.numberWithOptions(decimal: true),
                    initialValue: remainAmount.toString(),
                    onChange: (str) {
                      setState(() {
                        if (str.isEmpty) {
                          remainAmount = 0;
                        } else {
                          remainAmount = num.parse(str);
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CommonTextField(
                    titleText: VariableUtils.remark,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    initialValue: remark,
                    maxLine: 4,
                    onChange: (str) {
                      remark = str;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: richText(
                    key:
                        '${VariableUtils.txCharge} (${ConstUtils.formatDouble(double.parse(txCharge))}%) : ',
                    value: '${remainAmount * (num.parse(txCharge) / 100)}',
                  ),
                ),
                SizeConfig.sH10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: richText(
                    key: '${VariableUtils.total} : ',
                    value:
                        '${remainAmount + (remainAmount * (num.parse(txCharge) / 100))}',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GetBuilder<FeesViewModel>(
                          tag: FeesViewModel().toString(),
                          builder: (con) {
                            if (con.applyFeesPaymentApiResponse.status ==
                                Status.LOADING) {
                              return CircularProgressIndicator();
                            }
                            return TextButton(
                                onPressed: () async {
                                  if (remainAmount >
                                      (data.demandAmount ?? 0) -
                                          (data.paidAmt ?? 0)) {
                                    showToast(
                                        msg: VariableUtils
                                            .pleaseCheckAmountFailedMsg);
                                    return;
                                  }
                                  razorPayService(
                                      tax: remainAmount *
                                          (num.parse(txCharge) / 100),
                                      amount: remainAmount.toDouble(),
                                      razorKey:
                                          paymentListResModel.razorpayKey!,
                                      feesId: data.feeId!);
                                },
                                child: Text(VariableUtils.pay));
                          }),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(VariableUtils.close))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

Text richText({required String key, required String value}) {
  return Text.rich(TextSpan(children: [
    TextSpan(text: key, style: FontTextStyle.poppinsW5S12Grey),
    TextSpan(
      text: value,
      style: FontTextStyle.poppinsW7S12DarkGrey,
    )
  ]));
}
