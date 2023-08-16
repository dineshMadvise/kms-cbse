import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_financial_report_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';

class FinancialReport extends StatelessWidget {
  FinancialReport({Key? key}) : super(key: key);

  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.financialReport,
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
        height: Get.height,
        width: Get.width,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: DecorationUtils.commonDecorationBox(),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GetBuilder<ReportViewModel>(
          tag: ReportViewModel().toString(),
          initState: (state) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              reportViewModel.getFinancialReportsAttendance();
            });
          },
          builder: (controller) {
            if (controller.financialReportApiResponse.status ==
                    Status.LOADING ||
                controller.financialReportApiResponse.status ==
                    Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (controller.financialReportApiResponse.status == Status.ERROR) {
              return getDataErrorMsg();
            }
            GetFinancialReportResModel model =
                controller.financialReportApiResponse.data;
            if (model.status != VariableUtils.ok) {
              return getFieldIsEmptyMsg();
            }
            return ListView(
              children: [

                // Text(
                //   VariableUtils.forAcademicYear +
                //       "${DateTime.now().year - 1}-${DateTime.now().year}",
                //   style: FontTextStyle.poppinsW6S13Purple,
                // ),
                SizeConfig.sH20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: HeaderPart(
                      color: Colors.lightBlue,
                      title: model.data?.totalAmount?.title ??
                          VariableUtils.totalAmount,
                      value: '${model.data?.totalAmount?.amount ?? "0"}',
                    )),
                    SizeConfig.sW5,
                    Expanded(
                        child: HeaderPart(
                      color: Colors.green,
                      title: model.data?.receivedAmount?.title ??
                          VariableUtils.collected,
                      //     title: 'Total Amount 222',
                      value: '${model.data?.receivedAmount?.amount ?? "0"}',
                    )),
                    SizeConfig.sW5,
                    Expanded(
                        child: HeaderPart(
                      color: Colors.yellow.shade600,
                      title: model.data?.pendingAmount?.title ??
                          VariableUtils.pending,
                      value: '${model.data?.pendingAmount?.amount ?? "0"}',
                    )),
                  ],
                ),

                SizeConfig.sH30,
                Text(
                  VariableUtils.yearlySummary,
                  style: FontTextStyle.poppinsW6S13Purple,
                ),
                SizedBox(
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: ConstUtils.financialReportTableList
                                .map((e) => Expanded(
                                      flex: 1,
                                      child: Text(
                                        e,
                                        style: FontTextStyle.poppinsW6S14Black,
                                        textAlign: TextAlign.left,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: model.data!.list!
                                .map((e) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${e.month}",
                                                  textAlign: TextAlign.left,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${e.income}",
                                                  textAlign: TextAlign.left,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${e.expense}",
                                                  textAlign: TextAlign.left,
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${e.salary}",
                                                  textAlign: TextAlign.left,
                                                )),
                                          ],
                                        ),
                                        model.data!.list!.indexOf(e) <
                                                model.data!.list!.length - 1
                                            ? const Divider()
                                            : SizeConfig.sH5,
                                      ],
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}

class HeaderPart extends StatelessWidget {
  const HeaderPart({
    Key? key,
    required this.title,
    required this.value,
    required this.color,

  }) : super(key: key);
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 37,
          
          child: Text(
            title,
            style: FontTextStyle.poppinsW6S14Black,
          ),
        ),
        SizeConfig.sH10,
        Container(
          height: 70,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              value,
              style: FontTextStyle.poppinsW6S16White,
            ),
          ),
        ),
      ],
    );
  }
}
