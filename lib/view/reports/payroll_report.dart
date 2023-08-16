// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payroll_report_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';

class PayrollReport extends StatelessWidget {
  PayrollReport({Key? key}) : super(key: key);

  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());
  Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.payrollReport,
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
        child: Column(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () {
                  showMonthPicker(
                    context: context,
                    initialDate: DateTime.now(),
                  ).then((date) {
                    print('date ==$date');
                    if (date != null) {
                      selectedDate.value = date;
                      reportViewModel.getPayrollReportsAttendance(date);
                    }
                  });
                },
                child: AbsorbPointer(
                  child: CustomDateTimeTextField(
                    isTitleVisible: false,
                    key: ValueKey(selectedDate.value),
                    titleText: VariableUtils.date,
                    initialValue: selectedDate.value,
                    dateFormat: DateFormatUtils.MMMString,
                    firstDate: DateTime(2000),
                    onChangeDateTime: (value) {},
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<ReportViewModel>(
                tag: ReportViewModel().toString(),
                initState: (state) {
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                    reportViewModel.getPayrollReportsAttendance(DateTime.now());
                  });
                },
                builder: (controller) {
                  if (controller.payrollReportApiResponse.status ==
                          Status.LOADING ||
                      controller.payrollReportApiResponse.status ==
                          Status.INITIAL) {
                    return getDataLoadingIndicator();
                  }
                  if (controller.payrollReportApiResponse.status ==
                      Status.ERROR) {
                    return getDataErrorMsg();
                  }
                  GetPayrollReportResModel model =
                      controller.payrollReportApiResponse.data;
                  if (model.status != VariableUtils.ok || model.total == null) {
                    return emptyMsg();
                  }

                  return ListView(
                    children: [
                      // Text(
                      //   VariableUtils.forAcademicYear +
                      //       "${DateTime.now().year - 1}-${DateTime.now().year}",
                      //   style: FontTextStyle.poppinsW6S13Purple,
                      // ),
                      // SizeConfig.sH20,
                      // Text(
                      //   VariableUtils.month +
                      //       " : ${DateFormatUtils.MMMFormat(DateTime.now())}",
                      //   style: FontTextStyle.poppinsW6S13Purple,
                      // ),
                      SizeConfig.sH20,
                      SizedBox(
                        width: Get.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // const Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      ConstUtils.payrollReportTableList.length,
                                      (index) => Expanded(
                                            flex: index == 0 ? 1 : 2,
                                            child: Text(
                                              ConstUtils.payrollReportTableList[
                                                  index],
                                              style: FontTextStyle
                                                  .poppinsW6S14Black,
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                      model.data!.length,
                                      (index) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "${index + 1}",
                                                        textAlign:
                                                            TextAlign.left,
                                                      )),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "${model.data![index].staffName}",
                                                        textAlign:
                                                            TextAlign.left,
                                                      )),
                                                  // Expanded(
                                                  //     flex: 2,
                                                  //     child: Text(
                                                  //       "${model.data![index].month}",
                                                  //       textAlign:
                                                  //           TextAlign.left,
                                                  //     )),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "${model.data![index].totalLeave}",
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "${model.data![index].salary}",
                                                        textAlign:
                                                            TextAlign.left,
                                                      )),
                                                  Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          downloadFile(model
                                                              .data![index]
                                                              .receipt!);
                                                        },
                                                        child: const Icon(Icons
                                                            .download_for_offline_outlined),
                                                      )),
                                                ],
                                              ),
                                              index < model.data!.length - 1
                                                  ? const Divider()
                                                  : SizeConfig.sH5,
                                            ],
                                          )),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
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
      children: [
        Text(
          title,
          style: FontTextStyle.poppinsW6S14Black,
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
