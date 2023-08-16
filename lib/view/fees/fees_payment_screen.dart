import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_fees_payment_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/fees_viewmodel.dart';

class FeesPaymentScreen extends StatefulWidget {
  @override
  _FeesPaymentScreenState createState() => _FeesPaymentScreenState();
}

class _FeesPaymentScreenState extends State<FeesPaymentScreen> {
  FeesViewModel viewModel = Get.find(tag: FeesViewModel().toString());
  late UserData userData;
  late String mainReceiptLink;

  @override
  void initState() {
    init();
    print('LINK :=>${Get.arguments}');
    mainReceiptLink = Get.arguments;
    super.initState();
  }

  void init() {
    viewModel.getFeesPaymentList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.feesPayment, centerTitle: true),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent))
          SmallUserProfileBox(),
        Expanded(
          child: Container(
            decoration: DecorationUtils.commonDecorationBox(),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: GetBuilder<FeesViewModel>(
                      tag: FeesViewModel().toString(),
                      builder: (controller) {
                        if (controller.getFeesPaymentListApiResponse.status ==
                                Status.LOADING ||
                            controller.getFeesPaymentListApiResponse.status ==
                                Status.INITIAL) {
                          return getDataLoadingIndicator();
                        }
                        if (controller.getFeesPaymentListApiResponse.status ==
                            Status.ERROR) {
                          return getDataErrorMsg();
                        }
                        GetFeesPaymentListResModel model =
                            controller.getFeesPaymentListApiResponse.data;
                        if (model.status != VariableUtils.ok) {
                          return getFieldIsEmptyMsg();
                        }
                        print('LENGTH:${model.data!.length}');
                        return model.data!.isEmpty
                            ? getNotApplicableMsg(msg: model.msg)
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                                child: SizedBox(
                                  width: Get.width,
                                  height: Get.height,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            color: ColorUtils.black2,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 8),
                                            child: Row(
                                              children: ConstUtils
                                                  .kFeesPaymentTableRowList
                                                  .map((e) => Expanded(
                                                      flex:
                                                          e == VariableUtils.no
                                                              ? 1
                                                              : 2,
                                                      child: Text(
                                                        e,
                                                        style: FontTextStyle
                                                            .poppinsW6S14White,
                                                        textAlign:
                                                            TextAlign.center,
                                                      )))
                                                  .toList(),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        ColorUtils.lightGrey)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: model.data!
                                                  .map((e) => Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          if (model.data!
                                                                  .indexOf(e) ==
                                                              0)
                                                            SizeConfig.sH5,
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${model.data!.indexOf(e) + 1}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FontTextStyle
                                                                        .poppinsW5S10Black,
                                                                  )),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    "${e.refno ?? VariableUtils.none}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FontTextStyle
                                                                        .poppinsW5S10Black,
                                                                  )),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    "${e.feename ?? VariableUtils.none}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FontTextStyle
                                                                        .poppinsW5S10Black,
                                                                  )),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    "${e.paymentDate ?? VariableUtils.none}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FontTextStyle
                                                                        .poppinsW5S10Black,
                                                                  )),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    // "${e.paidAmount ?? VariableUtils.none}",
                                                                    ConstUtils
                                                                        .kAmountValue(
                                                                            e.paidAmount!),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FontTextStyle
                                                                        .poppinsW5S10Black,
                                                                  )),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Center(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        downloadFile(
                                                                            e.receipt!,
                                                                            openFileStatus: true);
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        ConstUtils
                                                                            .kDownloadIcon,
                                                                        color: ColorUtils
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          model.data!.indexOf(
                                                                      e) <
                                                                  model.data!
                                                                          .length -
                                                                      1
                                                              ? Divider()
                                                              : SizeConfig.sH5,
                                                        ],
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: SingleChildScrollView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   child: DataTable(
                                    //       columnSpacing: 10,
                                    //       headingRowHeight: 40,
                                    //       horizontalMargin: 5,
                                    //       headingRowColor:
                                    //           MaterialStateColor.resolveWith(
                                    //               (states) =>
                                    //                   ColorUtils.black2),
                                    //       decoration: BoxDecoration(
                                    //           border: Border.all(
                                    //               color: ColorUtils.grey,
                                    //               width: 0.2)),
                                    //       // border: TableBorder.all(
                                    //       //     color: ColorUtils.grey,
                                    //       //     width: 0.2),
                                    //       columns: ConstUtils
                                    //           .kFeesPaymentTableRowList
                                    //           .map(
                                    //             (e) => DataColumn(
                                    //                 label: Text(
                                    //               e,
                                    //               style: FontTextStyle
                                    //                   .poppinsW6S12White,
                                    //               textAlign: TextAlign.left,
                                    //             )),
                                    //           )
                                    //           .toList(),
                                    //       rows: model.data!
                                    //           .map(
                                    //             (e) => DataRow(cells: [
                                    //               DataCell(
                                    //                 SizedBox(
                                    //                   width: 20,
                                    //                   child: Center(
                                    //                     child: Text(
                                    //                       "${model.data!.indexOf(e) + 1}",
                                    //                       textAlign:
                                    //                           TextAlign.center,
                                    //                       style: FontTextStyle
                                    //                           .poppinsW5S12Black,
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               DataCell(SizedBox(
                                    //                 width: 60,
                                    //                 child: Center(
                                    //                     child: Text(
                                    //                   e.refno ??
                                    //                       VariableUtils.none,
                                    //                   style: FontTextStyle
                                    //                       .poppinsW5S12Black,
                                    //                 )),
                                    //               )),
                                    //               DataCell(SizedBox(
                                    //                 width: 60,
                                    //                 child: Center(
                                    //                     child: Text(
                                    //                   e.feename ??
                                    //                       VariableUtils.none,
                                    //                   style: FontTextStyle
                                    //                       .poppinsW5S12Black,
                                    //                 )),
                                    //               )),
                                    //               DataCell(SizedBox(
                                    //                 width: 60,
                                    //                 child: Center(
                                    //                   child: Text(
                                    //                     e.paymentDate ??
                                    //                         VariableUtils.none,
                                    //                     textAlign:
                                    //                         TextAlign.center,
                                    //                     style: FontTextStyle
                                    //                         .poppinsW5S12Black,
                                    //                   ),
                                    //                 ),
                                    //               )),
                                    //               DataCell(SizedBox(
                                    //                 width: 55,
                                    //                 child: Center(
                                    //                     child: Text(
                                    //                   e.paidAmount ??
                                    //                       VariableUtils.none,
                                    //                   style: FontTextStyle
                                    //                       .poppinsW5S12Black,
                                    //                 )),
                                    //               )),
                                    //               DataCell(SizedBox(
                                    //                 width: 20,
                                    //                 child: InkWell(
                                    //                   onTap: () {
                                    //                     downloadFile(e.receipt!,
                                    //                         openFileStatus:
                                    //                             true);
                                    //                   },
                                    //                   child: const Icon(
                                    //                     ConstUtils
                                    //                         .kDownloadIcon,
                                    //                     color: ColorUtils.blue,
                                    //                   ),
                                    //                 ),
                                    //               )),
                                    //             ]),
                                    //           )
                                    //           .toList()),
                                    // ),
                                  ),
                                ),
                              );
                      }),
                ),
                CustomBtn(
                    radius: 10,
                    onTap: () {
                      downloadFile(mainReceiptLink, openFileStatus: true);
                    },
                    isDownloadFile: true,
                    width: Get.width * 0.8,
                    title: VariableUtils.downloadReceipt)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
