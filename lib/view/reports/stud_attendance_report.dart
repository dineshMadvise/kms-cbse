import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import '../../common/commonMethods/custom_appbar.dart';
import '../../common/commonMethods/loading_indicator.dart';

import '../../model/apiModel/responseModel/stud_attendance_report_res_model.dart';
import '../../model/apis/api_response.dart';
import '../../utils/dateformat_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/dashboard_viewmodel.dart';

class StudAttendanceReports extends StatelessWidget {
  StudAttendanceReports({Key? key}) : super(key: key);

  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.studentAttendance,
        centerTitle: true,
      ),
      body: Container(
          height: Get.height,
          width: Get.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          decoration: DecorationUtils.commonDecorationBox(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              CustomDateTimeTextField(
                titleText: VariableUtils.date,
                isTitleVisible: false,
                initialValue: DateTime.now(),
                firstDate: DateTime(1997),
                onChangeDateTime: (value) {
                  reportViewModel.studAttendanceReport(
                    value,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const ColorPalette(
                color: Colors.green,
                text: "TOTAL PRESENT",
              ),
              const SizedBox(
                height: 5,
              ),
              const ColorPalette(
                color: Colors.red,
                text: "TOTAL ABSENT",
              ),
              const SizedBox(
                height: 5,
              ),
              const ColorPalette(
                color: Colors.yellow,
                text: "TOTAL NOT MARKED",
              ),
              GetBuilder<ReportViewModel>(
                tag: ReportViewModel().toString(),
                initState: (state) {
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                    reportViewModel.studAttendanceReport(DateTime.now());
                  });
                },
                builder: (controller) {
                  if (controller.studAttendanceReportApiResponse.status ==
                          Status.LOADING ||
                      controller.studAttendanceReportApiResponse.status ==
                          Status.INITIAL) {
                    return Expanded(
                      child: Center(child: getDataLoadingIndicator()),
                    );
                  }
                  if (controller.studAttendanceReportApiResponse.status ==
                      Status.ERROR) {
                    return Expanded(child: Center(child: getDataErrorMsg()));
                  }
                  final StudAttendanceReportResModel reportsAttendanceResModel =
                      controller.studAttendanceReportApiResponse.data;
                  if (reportsAttendanceResModel.status != VariableUtils.ok) {
                    return Expanded(child: Center(child: getFieldIsEmptyMsg()));
                  }

                  final List<ChartData> chartData = [];

                  if ((reportsAttendanceResModel.dATA?.first.tOTALPRESENT ??
                          0) >
                      0) {
                    chartData.add(
                      ChartData(
                          'TOTAL PRESENT',
                          (reportsAttendanceResModel.dATA?.first.tOTALPRESENT ??
                                  0)
                              .toDouble(),
                          Colors.green,
                          reportsAttendanceResModel.dATA?.first.tOTALPRESENT ??
                              0),
                    );
                  }
                  if ((reportsAttendanceResModel.dATA?.first.tOTALABSENT ?? 0) >
                      0) {
                    chartData.add(
                      ChartData(
                          'TOTAL ABSENT',
                          (reportsAttendanceResModel.dATA?.first.tOTALABSENT ??
                                  0)
                              .toDouble(),
                          Colors.red,
                          reportsAttendanceResModel.dATA?.first.tOTALABSENT ??
                              0),
                    );
                  }
                  if ((reportsAttendanceResModel.dATA?.first.tOTALNOTMARKED ??
                          0) >
                      0) {
                    chartData.add(
                      ChartData(
                          'TOTAL NOT MARKED',
                          (reportsAttendanceResModel
                                      .dATA?.first.tOTALNOTMARKED ??
                                  0)
                              .toDouble(),
                          Colors.yellow,
                          reportsAttendanceResModel
                                  .dATA?.first.tOTALNOTMARKED ??
                              0),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Total Students : ${reportsAttendanceResModel.dATA?.first.totalStudent}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      SfCircularChart(series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelMapper: (ChartData data, _) =>
                              data.lable == 0 ? "0" : data.lable.toString(),
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              alignment: ChartAlignment.center,
                              textStyle: TextStyle(fontSize: 25)),
                        )
                      ]),
                    ],
                  );
                },
              )
            ],
          )),
    );
  }
}

class ColorPalette extends StatelessWidget {
  const ColorPalette({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: color),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color, this.lable);

  final String x;
  final double y;
  final Color color;
  final int lable;
}
