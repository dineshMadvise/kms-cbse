import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../common/commonMethods/custom_appbar.dart';
import '../../common/commonMethods/loading_indicator.dart';
import '../../model/apiModel/responseModel/staff_attendance_report_res_model.dart';
import '../../model/apis/api_response.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/variable_utils.dart';

class StaffAttendanceReports extends StatelessWidget {
  StaffAttendanceReports({Key? key}) : super(key: key);

  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.staffAttendance,
        centerTitle: true,
      ),
      body: Container(
          height: Get.height,
          width: Get.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          decoration: DecorationUtils.commonDecorationBox(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomDateTimeTextField(
                  titleText: VariableUtils.date,
                  isTitleVisible: false,
                  initialValue: DateTime.now(),
                  firstDate: DateTime(1997),
                  onChangeDateTime: (value) {
                    reportViewModel.staffAttendanceReport(
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
                      reportViewModel.staffAttendanceReport(DateTime.now());
                    });
                  },
                  builder: (controller) {
                    if (controller.staffAttendanceReportApiResponse.status ==
                            Status.LOADING ||
                        controller.staffAttendanceReportApiResponse.status ==
                            Status.INITIAL) {
                      return Center(child: getDataLoadingIndicator());
                    }
                    if (controller.staffAttendanceReportApiResponse.status ==
                        Status.ERROR) {
                      return Center(child: getDataErrorMsg());
                    }
                    final StaffAttendanceReportResModel
                        reportsAttendanceResModel =
                        controller.staffAttendanceReportApiResponse.data;
                    if (reportsAttendanceResModel.status != VariableUtils.ok) {
                      return Center(child: getFieldIsEmptyMsg());
                    }

                    /// ====================== STAFF CHAT DATA COLLECT ====================== ///
                    final List<ChartData> staffChartData = [];

                    if ((reportsAttendanceResModel.data?.staff?.totalpresent ??
                            0) >
                        0) {
                      staffChartData.add(
                        ChartData(
                            'TOTAL PRESENT',
                            (reportsAttendanceResModel
                                        .data?.staff?.totalpresent ??
                                    0)
                                .toDouble(),
                            Colors.green,
                            (reportsAttendanceResModel
                                        .data?.staff?.totalpresent ??
                                    0)
                                .toInt()),
                      );
                    }
                    if ((reportsAttendanceResModel.data?.staff?.totalpresent ??
                            0) >
                        0) {
                      staffChartData.add(
                        ChartData(
                            'TOTAL ABSENT',
                            (reportsAttendanceResModel
                                        .data?.staff?.totalabsent ??
                                    0)
                                .toDouble(),
                            Colors.red,
                            (reportsAttendanceResModel
                                        .data?.staff?.totalabsent ??
                                    0)
                                .toInt()),
                      );
                    }
                    if ((reportsAttendanceResModel
                                .data?.staff?.totalnotmarked ??
                            0) >
                        0) {
                      staffChartData.add(
                        ChartData(
                            'TOTAL NOT MARKED',
                            (reportsAttendanceResModel
                                        .data?.staff?.totalnotmarked ??
                                    0)
                                .toDouble(),
                            Colors.yellow,
                            (reportsAttendanceResModel
                                        .data?.staff?.totalpresent ??
                                    0)
                                .toInt()),
                      );
                    }

                    /// ====================== TEACHER CHAT DATA COLLECT ====================== ///

                    final List<ChartData> teacherChartData = [];

                    if ((reportsAttendanceResModel
                                .data?.teacher?.totalpresent ??
                            0) >
                        0) {
                      teacherChartData.add(
                        ChartData(
                            'TOTAL PRESENT',
                            (reportsAttendanceResModel
                                        .data?.teacher?.totalpresent ??
                                    0)
                                .toDouble(),
                            Colors.green,
                            (reportsAttendanceResModel
                                        .data?.teacher?.totalpresent ??
                                    0)
                                .toInt()),
                      );
                    }
                    if ((reportsAttendanceResModel
                                .data?.teacher?.totalpresent ??
                            0) >
                        0) {
                      teacherChartData.add(
                        ChartData(
                            'TOTAL ABSENT',
                            (reportsAttendanceResModel
                                        .data?.teacher?.totalabsent ??
                                    0)
                                .toDouble(),
                            Colors.red,
                            (reportsAttendanceResModel
                                        .data?.teacher?.totalabsent ??
                                    0)
                                .toInt()),
                      );
                    }
                    if ((reportsAttendanceResModel
                                .data?.teacher?.totalnotmarked ??
                            0) >
                        0) {
                      teacherChartData.add(
                        ChartData(
                            'TOTAL NOT MARKED',
                            (reportsAttendanceResModel
                                        .data?.teacher?.totalnotmarked ??
                                    0)
                                .toDouble(),
                            Colors.yellow,
                            (reportsAttendanceResModel
                                        .data?.teacher?.totalpresent ??
                                    0)
                                .toInt()),
                      );
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Total Staff : ${reportsAttendanceResModel.data?.staff?.totalstaff ?? 0}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        SfCircularChart(series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataSource: staffChartData,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Total Teacher : ${reportsAttendanceResModel.data?.teacher?.totalteacher ?? 0}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        SfCircularChart(series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataSource: teacherChartData,
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
            ),
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
