import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_progress_report_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/progress_report_viewmodel.dart';

class ProgressReportScreen extends StatefulWidget {
  @override
  _ProgressReportScreenState createState() => _ProgressReportScreenState();
}

class _ProgressReportScreenState extends State<ProgressReportScreen> {
  ProgressReportViewModel _viewModel =
      Get.find(tag: ProgressReportViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _viewModel.getProgressReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppbar(title: VariableUtils.progressReport, centerTitle: true),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<ProgressReportViewModel>(
        tag: ProgressReportViewModel().toString(),
        builder: (controller) {
          if (controller.getProgressReportApiResponse.status ==
                  Status.LOADING ||
              controller.getProgressReportApiResponse.status ==
                  Status.INITIAL) {
            return getDataLoadingIndicator();
          }
          if (controller.getProgressReportApiResponse.status == Status.ERROR) {
            return getDataErrorMsg();
          }
          GetProgressReportResModel model =
              controller.getProgressReportApiResponse.data;
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
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columnSpacing: 30,
                            headingRowHeight: 40,
                            horizontalMargin: 10,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => ColorUtils.black2),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorUtils.grey, width: 0.2)),
                            // border: TableBorder.all(
                            //     color: ColorUtils.grey, width: 0.2),
                            columns: ConstUtils.kProgressReportTableRowList
                                .map(
                                  (e) => DataColumn(
                                      label: Text(
                                    e,
                                    style: FontTextStyle.poppinsW6S14White,
                                    textAlign: TextAlign.left,
                                  )),
                                )
                                .toList(),
                            rows: model.data!
                                .map(
                                  (e) => DataRow(cells: [
                                    DataCell(
                                      Center(
                                        child: Text(
                                            "${model.data!.indexOf(e) + 1}",
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                    DataCell(Center(
                                        child: Text(
                                            e.title ?? VariableUtils.none))),
                                    DataCell(Center(
                                        child: Text(e.createdOn ??
                                            VariableUtils.none))),
                                    DataCell(InkWell(
                                      onTap: () {
                                        downloadFile(e.progressReport!);
                                      },
                                      child: Icon(
                                        ConstUtils.kDownloadIcon,
                                        color: ColorUtils.blue,
                                      ),
                                    )),
                                  ]),
                                )
                                .toList()),
                      ),
                    ),
                  ),
                );
        });
  }
}
