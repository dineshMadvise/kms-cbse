// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/dialog/fees_pay_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payment_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/fees_viewmodel.dart';

class FeesScreen extends StatefulWidget {
  @override
  _FeesScreenState createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  FeesViewModel viewModel = Get.find(tag: FeesViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getPaymentList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.fees, centerTitle: true),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent))
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SmallUserProfileBox(),
          ),
        Expanded(
          child: Stack(
            children: [
              GetBuilder<FeesViewModel>(
                  tag: FeesViewModel().toString(),
                  builder: (controller) {
                    if (controller.getPaymentListApiResponse.status ==
                            Status.LOADING ||
                        controller.getPaymentListApiResponse.status ==
                            Status.INITIAL) {
                      return getDataLoadingIndicator();
                    }
                    if (controller.getPaymentListApiResponse.status ==
                        Status.ERROR) {
                      return getDataErrorMsg();
                    }
                    GetPaymentListResModel model =
                        controller.getPaymentListApiResponse.data;
                    if (model.status != VariableUtils.ok) {
                      return getFieldIsEmptyMsg();
                    }
                    print('LENGTH:${model.data!.length}');
                    return model.data!.isEmpty
                        ? getNotApplicableMsg(msg: model.msg)
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: SizedBox(
                              width: Get.width,
                              height: Get.height,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      color: ColorUtils.black2,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 15),
                                      child: Row(
                                        children: List.generate(
                                            ConstUtils.kFeesTableRowList.length,
                                            (index) {
                                          final e = ConstUtils
                                              .kFeesTableRowList[index];
                                          return Expanded(
                                              flex: index == 0
                                                  ? 1
                                                  : index ==
                                                          ConstUtils
                                                                  .kFeesTableRowList
                                                                  .length -
                                                              1
                                                      ? 2
                                                      : 3,
                                              child: Text(
                                                e,
                                                style: FontTextStyle
                                                    .poppinsW6S14White,
                                                textAlign: TextAlign.center,
                                              ));
                                        }),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorUtils.lightGrey)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                            model.data!.length + 1, (index) {
                                          if (index == model.data!.length) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 1,
                                                      child: SizedBox()),
                                                  const Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        VariableUtils.total,
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        model.summary!
                                                                .totalDemandAmount
                                                                ?.toString() ??
                                                            VariableUtils.none,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FontTextStyle
                                                            .poppinsW6S16Black,
                                                      )),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        "${model.summary!.totPaidAmount ?? VariableUtils.none}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FontTextStyle
                                                            .poppinsW6S16Black,
                                                      )),
                                                  const Expanded(
                                                      flex: 2,
                                                      child: SizedBox()),
                                                ],
                                              ),
                                            );
                                          }
                                          final e = model.data![index];
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Row(
                                                  children: [
                                                    if (model.data!
                                                            .indexOf(e) ==
                                                        0)
                                                      SizeConfig.sH30,
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (model.data!.indexOf(
                                                                      e) +
                                                                  1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          e.feeType ??
                                                              VariableUtils
                                                                  .none,
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "${e.demandAmount ?? VariableUtils.none}",
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "${e.paidAmt ?? VariableUtils.none}",
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                    Expanded(
                                                      flex: 2,
                                                      child: e.demandAmount! >
                                                                  e.paidAmt! &&
                                                              model.razorpayKey !=
                                                                  null &&
                                                              model.razorpayKey !=
                                                                  ""
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                              child: CustomBtn(
                                                                  onTap: () {
                                                                    showFeesPayDialog(
                                                                        e,
                                                                        model.paymentTransactionPer ??
                                                                            "",
                                                                        model);
                                                                  },
                                                                  height: 30,
                                                                  title:
                                                                      VariableUtils
                                                                          .pay),
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              model.data!.indexOf(e) <
                                                      model.data!.length
                                                  ? const Divider()
                                                  : SizeConfig.sH5,
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    CustomBtn(
                                        radius: 10,
                                        onTap: () {
                                          if (model.summary != null) {
                                            RouteUtils.navigateRoute(
                                                RouteUtils.feesPaymentScreen,
                                                args: model.summary!.receipt);
                                          }
                                        },
                                        width: Get.width * 0.8,
                                        title: VariableUtils.downloadReceipt)
                                  ],
                                ),
                              ),
                            ),
                          );
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Widget richText({required String key, required String value}) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              key,
              style: FontTextStyle.poppinsW5S16Grey,
            )),
        Expanded(
          flex: 1,
          child: Text(
            ' : ',
            style: FontTextStyle.poppinsW5S16Grey,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              value,
              style: FontTextStyle.poppinsW6S16DarkGrey,
              textAlign: TextAlign.left,
            ))
      ],
    );
  }
}
