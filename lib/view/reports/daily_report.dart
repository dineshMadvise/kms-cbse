import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/daily_report_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';

class DailyReport extends StatelessWidget {
  DailyReport({Key? key}) : super(key: key);

  final DashBoardViewModel dashBoardViewModel =
  Get.find<DashBoardViewModel>(tag: DashBoardViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.dailyReport,
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return

      Container(
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
              onChangeDateTime: (date) {
                dashBoardViewModel.getDailyReport(date);
              },
            ),
            SizeConfig.sH20,
            GetBuilder<DashBoardViewModel>(
              tag: DashBoardViewModel().toString(),
              initState: (state) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  dashBoardViewModel.getDailyReport(DateTime.now());
                });
              },
              builder: (controller) {
                if (controller.dailyReportApiResponse.status ==
                    Status.LOADING ||
                    controller.dailyReportApiResponse.status ==
                        Status.INITIAL) {
                  return Expanded(child: getDataLoadingIndicator());
                }
                if (controller.dailyReportApiResponse.status == Status.ERROR) {
                  return Expanded(child: getDataErrorMsg());
                }
                DailyReportResModel model =
                    controller.dailyReportApiResponse.data;
                if (model.status != VariableUtils.ok) {
                  return getFieldIsEmptyMsg();
                }
                return InkWell(
                  onTap: () {
                    downloadFile(model.url ?? "");
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorUtils.lightGrey),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          VariableUtils.downLoadDailyReport,
                          style: FontTextStyle.poppinsW6S13Purple,
                        ),
                        const Icon(
                          Icons.download_for_offline_outlined,
                          color: ColorUtils.blue,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );

  }
}
