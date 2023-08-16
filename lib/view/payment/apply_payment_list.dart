import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_apply_payment_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/payment_viewmodel.dart';

class ApplyPaymentList extends StatelessWidget {
  ApplyPaymentList({Key? key}) : super(key: key);

  final PaymentViewModel paymentViewModel =
      Get.find<PaymentViewModel>(tag: PaymentViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.applyPayment,
          centerTitle: true,
          actionVisible: true,
          onActionTap: () async {
            RouteUtils.navigateRoute(
              RouteUtils.applyPayment,
            );
          }),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
        height: Get.height,
        width: Get.width,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: DecorationUtils.commonDecorationBox(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GetBuilder<PaymentViewModel>(
          tag: PaymentViewModel().toString(),
          initState: (state) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              paymentViewModel.currentValue = DateTime.now();
              paymentViewModel.getPaymentList();
            });
          },
          builder: (controller) {
            if (controller.getPaymentListApiResponse.status == Status.LOADING ||
                controller.getPaymentListApiResponse.status == Status.INITIAL) {
              return Column(
                children: [
                  DatePickBox(
                    controller: controller,
                  ),
                  SizeConfig.sH5,
                  Expanded(child: getDataLoadingIndicator()),
                ],
              );
            }
            if (controller.getPaymentListApiResponse.status == Status.ERROR) {
              return Column(
                children: [
                  DatePickBox(
                    controller: controller,
                  ),
                  SizeConfig.sH5,
                  Expanded(child: getDataErrorMsg()),
                ],
              );
            }
            GetApplyPaymentListResModel model =
                controller.getPaymentListApiResponse.data;
            if (model.status != VariableUtils.ok) {
              return Column(
                children: [
                  DatePickBox(
                    controller: controller,
                  ),
                  SizeConfig.sH5,
                  Expanded(child: getFieldIsEmptyMsg()),
                ],
              );
            }
            print('LENGTH:${model.data!.length}');
            if (model.data!.isEmpty) {
              return Column(
                children: [
                  DatePickBox(
                    controller: controller,
                  ),
                  SizeConfig.sH5,
                  Expanded(child: getNotApplicableMsg(msg: model.msg)),
                ],
              );
            } else {
              return Column(
                children: [
                  DatePickBox(
                    controller: controller,
                  ),
                  SizeConfig.sH5,
                  Expanded(
                    child: ListView.separated(
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        final data = model.data![index];
                        return InkWell(
                          onTap: () {
                            // showLeaveApprovalDialog(data);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DateBox(
                                      text: data.dateTime ?? VariableUtils.none,
                                      textStyle: FontTextStyle.poppinsW6S13Grey,
                                    ),
                                    SizeConfig.sH10,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              data.feeName ??
                                                  VariableUtils.none,
                                              style: FontTextStyle
                                                  .poppinsW7S12DarkGrey,
                                            )),
                                        SizeConfig.sW5,
                                        Expanded(
                                          flex: 1,
                                          child: richText(
                                              key: VariableUtils.amount + " : ",
                                              value: data.paidAmount ??
                                                  VariableUtils.none),
                                        )
                                      ],
                                    ),
                                    SizeConfig.sH10,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: richText(
                                              key: VariableUtils.name,
                                              value: data.studentName ??
                                                  VariableUtils.none),
                                        ),
                                        SizeConfig.sW5,
                                        Expanded(
                                          child: richText(
                                              key: VariableUtils.classStr +
                                                  " : ",
                                              value: data.classStr ??
                                                  VariableUtils.none),
                                        ),
                                      ],
                                    ),
                                    SizeConfig.sH10,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: richText(
                                              key: VariableUtils.paymentMode +
                                                  " : ",
                                              value: data.paymentMode ??
                                                  VariableUtils.none),
                                        ),
                                        SizeConfig.sW5,
                                        Expanded(
                                          child: richText(
                                              key:
                                                  VariableUtils.receipt + " : ",
                                              value: data.receipt ??
                                                  VariableUtils.none,
                                              link: data.receiptUrl),
                                        ),
                                      ],
                                    ),
                                    SizeConfig.sH10,
                                  ],
                                ),
                              ),
                              SizeConfig.sW10,
                              // InkWell(
                              //   onTap: () {
                              //     // showLeaveApprovalDialog(data);
                              //   },
                              //   child: const AddOrForwordCircleBox(
                              //     icon: ConstUtils.kForwordArrowIcon,
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Divider(),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }

  Widget richText({required String key, required String value, String? link}) {
    return InkWell(
      onTap: link != null
          ? () {
              downloadFile(link ?? "");
            }
          : null,
      child: Text.rich(TextSpan(children: [
        TextSpan(text: key, style: FontTextStyle.poppinsW5S12Grey),
        TextSpan(
          text: value,
          style: link != null
              ? FontTextStyle.poppinsW7S12Purple
              : FontTextStyle.poppinsW7S12DarkGrey,
        )
      ])),
    );
  }
}

class DatePickBox extends StatelessWidget {
  final PaymentViewModel controller;

  const DatePickBox({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomDateTimeTextField(
        titleText: VariableUtils.date,
        isTitleVisible: false,
        initialValue: DateTime.now(),
        firstDate: DateTime(1997),
        onChangeDateTime: (date) {
          if (date != null) {
            controller.currentValue = date;
            controller.getPaymentList();
          }
        },
      ),
    );
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            VariableUtils.date + " : ",
            style: FontTextStyle.poppinsW7S12DarkGrey,
          ),
          Text(DateFormatUtils.ddMMMYYYYFormat(controller.currentValue)),
          IconButton(
              onPressed: () async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1997),
                    initialDate: controller.currentValue,
                    lastDate: DateTime(2300));
                if (date != null) {
                  controller.currentValue = date;
                  controller.getPaymentList();
                }
              },
              icon: const Icon(Icons.calendar_today)),
        ],
      ),
    );
  }
}
