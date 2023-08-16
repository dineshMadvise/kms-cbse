import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payslip_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/pay_slip_viewmodel.dart';

class PaySlip extends StatefulWidget {
  @override
  _PaySlipState createState() => _PaySlipState();
}

class _PaySlipState extends State<PaySlip> {
  PaySlipViewModel _viewModel = Get.find(tag: PaySlipViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _viewModel.getPaySlipList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.paySlip, centerTitle: true),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<PaySlipViewModel>(
        tag: PaySlipViewModel().toString(),
        builder: (controller) {
          if (controller.getPaySlipListApiResponse.status == Status.LOADING ||
              controller.getPaySlipListApiResponse.status == Status.INITIAL) {
            return getDataLoadingIndicator();
          }
          if (controller.getPaySlipListApiResponse.status == Status.ERROR) {
            return getDataErrorMsg();
          }
          GetPayslipListResModel model =
              controller.getPaySlipListApiResponse.data;
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Row(
                              children: ConstUtils.kPaySLipTableRowList
                                  .map((e) => Expanded(
                                      flex: ConstUtils.kPaySLipTableRowList
                                                      .indexOf(e) ==
                                                  0 ||
                                              ConstUtils.kPaySLipTableRowList
                                                      .indexOf(e) ==
                                                  ConstUtils
                                                          .kPaySLipTableRowList
                                                          .length -
                                                      1
                                          ? 1
                                          : 2,
                                      child: Text(
                                        e,
                                        style: FontTextStyle.poppinsW6S14White,
                                        textAlign: TextAlign.center,
                                      )))
                                  .toList(),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorUtils.lightGrey)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: model.data!
                                  .map((e) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (model.data!.indexOf(e) == 0)
                                            SizeConfig.sH5,
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${e.sno ?? VariableUtils.none}",
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "${e.month ?? VariableUtils.none}",
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    ConstUtils.kAmountValue(
                                                        e.totalBasicPay!),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "${e.totalLeave ?? VariableUtils.none}",
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    // "${e.totGetSalaryAmount ?? VariableUtils.none}",
                                                    ConstUtils.kAmountValue(
                                                        e.totGetSalaryAmount!),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        downloadFile(
                                                            e.payslipPrint!,
                                                            openFileStatus:
                                                                true);
                                                      },
                                                      child: Icon(
                                                        ConstUtils
                                                            .kDownloadIcon,
                                                        color: ColorUtils.blue,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          model.data!.indexOf(e) <
                                                  model.data!.length - 1
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
                  ),
                );
        });
  }
}
